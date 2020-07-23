//
//  AddTagCollectionViewController.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class AddTagCollectionViewController: UICollectionViewController, Storyboarded{
    
    let dataSource: [String] = ["Office", "Social Events", "Holidays", "New Clients", "Campus", "Business Updates", "a"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        collectionView.indexPathsForSelectedItems?.forEach({ (IndexPath) in
            collectionView.deselectItem(at: IndexPath, animated: false)
        })
        collectionView.indexPathsForVisibleItems.forEach { (IndexPath) in
            let cell = collectionView.cellForItem(at: IndexPath) as! AddTagCollectionViewCell
            cell.isEditing = editing
                   
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



