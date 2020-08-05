//
//  ShowCategoriesViewController.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 27/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class ShowCategoriesViewController: UIViewController, Storyboarded {


    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var addTagButton: UIButton!{
        // Do this in the viewDidLoad, not on the didSet of the button
        //FILIP - moving it to viewDidLoad makes it so the call only happens initially,
        //FILIP - we need to make this call every time a category is chosen
        didSet{
            addTagButton.layer.cornerRadius = addTagButton.frame.size.height/5.0
            addTagButton.layer.masksToBounds = true
        }
    }
    
    var showCategoriesPresenter: ShowCategoriesPresenterProtocol!
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        showCategoriesPresenter.loadCategories()
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        // Make CategoryCell a constant
        let categoryCell = "CategoryCell"
        categoriesCollectionView.register(UINib(nibName: categoryCell, bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
    }
    
    @IBAction func addCategoryButtonTapped(_ sender: Any) {
        // This logic should be dealt with in the presenter so you can show an error to the user
        if categoryTextField.text == "" { return }
        
        // Hard coded category Id
        // SendCategory should take an optional string on category name so you don't force unwrap here
        //FILIP: Unsure how to handle this, why is the category id hardcoded ?
        showCategoriesPresenter.sendCategory(with: Category(categoryId: 66, categoryName: categoryTextField.text!))
        
    }
}

extension ShowCategoriesViewController: ShowCategoriesPresenterView {
    func emptyCategoryTextField() {
        categoryTextField.text = ""
    }
    
    func errorOccured(message: String) {
        let alert = UIAlertController(title: "Error", message: "An unexpected error occured", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Remove alert"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        print(message)
    }
    
    func setCategories(with categories: [Category]) {
        // This doesn't need to be done on the main queue
        DispatchQueue.main.async {
            self.categories = categories
        }
        categoriesCollectionView.reloadData()
    }
    
    
}

// This can all be made better if you move the dataSource into it's own object named ShowCategoriesDataSource

// This viewController would then have an object of that type on here and assign the collectionViews datasource and delegate to that

// This makes everything very clean and seperated

//FILIP: Unsure where to put this new object

extension ShowCategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCategory = categories[indexPath.item]
        showCategoriesPresenter.didSelectCategory(with: selectedCategory)
    }
    
}

extension ShowCategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentCategory = categories[indexPath.item]
        
        // Use CategoryCell constant
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        categoryCell.categoryLabel.text = currentCategory.categoryName
        return categoryCell
     
    }
    
}

extension ShowCategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

