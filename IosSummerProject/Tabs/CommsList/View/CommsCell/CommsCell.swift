//
//  CommsCell.swift
//  IosSummerProject
//
//  Created by Akash Mair on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit
import Kingfisher

class CommsCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var commsImageView: UIImageView!
    @IBOutlet weak var commsTitleLabel: UILabel!
   
    @IBOutlet weak var commsCategoryLabel: UIButton!
    
    
    @IBOutlet weak var highlightedImageView: UIImageView!
    
    @IBOutlet weak var commsDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.isHidden = true
        commsCategoryLabel.layer.cornerRadius = 5
        commsCategoryLabel.layer.masksToBounds = true
        commsTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    func downLoadImage(from url: String) {
        setLoading(isLoading: true)
        commsImageView.layer.cornerRadius = 5
        guard let url = URL(string: url) else {
            print("not a valid url")
            DispatchQueue.main.async {
                self.commsImageView.image = #imageLiteral(resourceName: "iOS FTW")
                self.setLoading(isLoading: false)
            }
            
            return
        }
        DispatchQueue.main.async {
            print(url,"url")
            self.commsImageView.kf.setImage(with: url)
            self.setLoading(isLoading: false)
        }
    }
}

