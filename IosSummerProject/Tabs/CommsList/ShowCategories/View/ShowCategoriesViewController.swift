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
        categoriesCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
    }
    
    @IBAction func addCategoryButtonTapped(_ sender: Any) {
        if categoryTextField.text == "" { return }
        showCategoriesPresenter.sendCategory(with: AddCategory(categoryName: categoryTextField.text!))
        categoryTextField.text = ""
    }
    

}

extension ShowCategoriesViewController: ShowCategoriesPresenterView {
    func addNewCategory(with new: Category) {
        DispatchQueue.main.async {
            self.categories.append(new)
            self.categoriesCollectionView.reloadData()
        }
    }
    
    func errorOccured(message: String) {
        print(message)
    }
    
    func setCategories(with categories: [Category]) {
        
        DispatchQueue.main.async {
            self.categories = categories
            self.categoriesCollectionView.reloadData()
        }
    }
    
    
}

extension ShowCategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        showCategoriesPresenter.didSelectCategory(with: selectedCategory)
    }
    
}

extension ShowCategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentCategory = categories[indexPath.row]
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

