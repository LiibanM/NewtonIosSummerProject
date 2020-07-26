//
//  PreviewTagCell.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 26/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class PreviewTagCell: UICollectionViewCell {
    
    
    @IBOutlet weak var tagName: UILabel!
    func configure(with tag: String!){
        tagName.text! = tag

    }
    
}
