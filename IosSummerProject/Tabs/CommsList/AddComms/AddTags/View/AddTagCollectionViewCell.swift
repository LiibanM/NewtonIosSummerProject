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
    
    let checkedImage = UIImage(named: "checked")! as UIImage
    let uncheckedImage = UIImage(named: "unchecked")! as UIImage
//
//    @IBOutlet weak var selectImage: UIImageView!{
//        didSet{
//            selectImage.image = uncheckedImage
//        }
//
//    }
//
//    @IBOutlet weak var tagNameLabel: UILabel!
//
//    @IBOutlet weak var selectLabel: UILabel!
//
//    var isEditing: Bool = false {
//        didSet{
//            selectImage.isHidden = !isEditing
//
//        }
//    }
//
//    override var isSelected: Bool{
//        didSet{
//            if isEditing{
//                if(isSelected) {
//                  selectImage.image = checkedImage
//                }
//                else{
//                   selectImage.image = uncheckedImage
//                }
//            }
//        }
//    }
    
    func configure(with tagName: String){
        tagNameLabel.text! = tagName

    }
}

