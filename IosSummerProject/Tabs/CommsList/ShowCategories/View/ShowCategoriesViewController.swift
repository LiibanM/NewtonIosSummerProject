//
//  ShowCategoriesViewController.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 27/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class ShowCategoriesViewController: UIViewController, Storyboarded {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var showCategoriesPresenter: ShowCategoriesPresenterProtocol!
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        showCategoriesPresenter.loadCategories()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
    }
    


}

extension ShowCategoriesViewController: ShowCategoriesPresenterView {
    func errorOccured(message: String) {
        print(message)
    }
    
    func setCategories(with categories: [Category]) {
        self.categories = categories
    }
    
    
}

extension ShowCategoriesViewController: UICollectionViewDelegate {
    
}

extension ShowCategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentCategory = categories[indexPath.row]
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        categoryCell.categoryLabel.text = currentCategory.category_name
        return categoryCell
     
    }
}


