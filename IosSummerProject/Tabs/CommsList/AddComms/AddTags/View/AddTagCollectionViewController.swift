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

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var cell = UICollectionViewCell()
        
        if let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AddTagCollectionViewCell{
            
            tagCell.configure(with: dataSource[indexPath.row])
            
            cell = tagCell
        }
        return cell
    }
}



