//
//  AddTagCollectionViewCell.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class AddTagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagNameLabel: UILabel!
    
    func configure(with tagName: String){
        tagNameLabel.text! = tagName

    }
}

