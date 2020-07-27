//
//  AddTagCollectionViewController.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class AddTagsViewController: UIViewController, Storyboarded{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var bottomNavBar: UINavigationBar!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var dataSource: [String] = ["Office", "Social Events", "Business Updata", "Holidays", "New Clients", "Communting"]
    var addTagPresenter: AddTagPresenterProtocol
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addTapped))
    }
    
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        collectionView.allowsMultipleSelection = editing
//        navigationItem.rightBarButtonItem?.isEnabled = !editing
//        bottomNavBar.isHidden = !editing
//        collectionView.indexPathsForSelectedItems?.forEach({ (IndexPath) in
//            collectionView.deselectItem(at: IndexPath, animated: false)
//        })
//        collectionView.indexPathsForVisibleItems.forEach { (IndexPath) in
//            let cell = collectionView.cellForItem(at: IndexPath) as! AddTagCollectionViewCell
//            cell.isEditing = editing
//
//        }
//    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        // Function body goes here
    }
    
    
//    @IBAction func deleteSelectedItems(_ sender: Any) {
//        if let selectedItems = collectionView.indexPathsForSelectedItems{
//            let items = selectedItems.map{$0.item}.sorted().reversed()
//            for item in items{
//                dataSource.remove(at: item)
//            }
//            collectionView.deleteItems(at: selectedItems)
//        }
//
//    }
    
    
    
    //finds what cell the user selected
     
}

extension AddTagsViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = dataSource[indexPath.item]
        print(selectedData)
    }
    
}

extension AddTagsViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var cell = UICollectionViewCell()
        
        if let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AddTagCollectionViewCell{
            
            tagCell.configure(with: dataSource[indexPath.row])
//            tagCell.isEditing = isEditing
            cell = tagCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
}

extension AddTagsViewController: AddTagPresenterView {
    
}


