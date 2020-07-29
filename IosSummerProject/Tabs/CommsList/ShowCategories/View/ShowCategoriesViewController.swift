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
        categoriesCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
    }
    
    @IBAction func addCategoryButtonTapped(_ sender: Any) {
        // This logic should be dealt with in the presenter so you can show an error to the user
        if categoryTextField.text == "" { return }
        
        // Hard coded category Id
        // SendCategory should take an optional string on category name so you don't force unwrap here
        showCategoriesPresenter.sendCategory(with: Category(category_id: 66, category_name: categoryTextField.text!))
        
        // This should be reset in a function in the ShowCategoriesPresenterView protocol not here
        categoryTextField.text = ""
    }
    

}

extension ShowCategoriesViewController: ShowCategoriesPresenterView {
    func errorOccured(message: String) {
        // Show an alert, dont print
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

extension ShowCategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Use indexPath.item as a row is specific to the section so it could be row 2 in section 3 but you are looking for item 12 in the categories array but would get category at location 2 in the array
        let selectedCategory = categories[indexPath.row]
        showCategoriesPresenter.didSelectCategory(with: selectedCategory)
    }
    
}

extension ShowCategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Same as comment above about using .item
        let currentCategory = categories[indexPath.row]
        
        // Use CategoryCell constant
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        categoryCell.categoryLabel.text = currentCategory.category_name
        return categoryCell
     
    }
    
    
}

// Spacing between functions, add whitelines!
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

