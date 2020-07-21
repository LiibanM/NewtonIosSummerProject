//
//  CommsCell.swift
//  IosSummerProject
//
//  Created by Akash Mair on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class CommsCell: UITableViewCell {

    @IBOutlet weak var commsImageView: UIImageView!
    @IBOutlet weak var commsTitleLabel: UILabel!
    @IBOutlet weak var commsCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsets(top: 8, left: 80, bottom: 8, right: 80)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

