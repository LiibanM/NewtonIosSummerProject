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
    }
    
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        commsImageView.image = #imageLiteral(resourceName: "comms-placeholder")
        // reset (hide) the checkmark label

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func downLoadImage(from url: String) {
        guard let url = URL(string: url) else {
            print("not valid url")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let downloadedImage = UIImage(data: data)
                    self.commsImageView.image = downloadedImage
                }
                return
            } else if error != nil {
                print("couldnt download image")
                return
            } else {
                print("Error")
            }
        }.resume()
    }
    

}

