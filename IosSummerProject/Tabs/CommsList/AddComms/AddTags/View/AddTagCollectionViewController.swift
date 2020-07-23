//
//  AddTagCollectionViewController.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class AddTagCollectionViewController: UICollectionViewController, Storyboarded{
    
    
    @IBOutlet weak var bottomNavBar: UINavigationBar!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var dataSource: [String] = ["Office", "Social Events", "Business Updata", "Holidays", "New Clients", "Communting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addTapped))
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        navigationItem.rightBarButtonItem?.isEnabled = !editing
        bottomNavBar.isHidden = !editing
        collectionView.indexPathsForSelectedItems?.forEach({ (IndexPath) in
            collectionView.deselectItem(at: IndexPath, animated: false)
        })
        collectionView.indexPathsForVisibleItems.forEach { (IndexPath) in
            let cell = collectionView.cellForItem(at: IndexPath) as! AddTagCollectionViewCell
            cell.isEditing = editing
                   
        }
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        // Function body goes here
    }
    
    
    @IBAction func deleteSelectedItems(_ sender: Any) {
        if let selectedItems = collectionView.indexPathsForSelectedItems{
            let items = selectedItems.map{$0.item}.sorted().reversed()
            for item in items{
                dataSource.remove(at: item)
            }
            collectionView.deleteItems(at: selectedItems)
        }
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var cell = UICollectionViewCell()
        
        if let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AddTagCollectionViewCell{
            
            tagCell.configure(with: dataSource[indexPath.row])
            tagCell.isEditing = isEditing
            cell = tagCell
        }
        return cell
    }
    
    //finds what cell the user selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = dataSource[indexPath.item]
        print(selectedData)
    }
}



