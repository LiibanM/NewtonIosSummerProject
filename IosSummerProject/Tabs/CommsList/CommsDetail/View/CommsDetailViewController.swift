//
//  AddCommsViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

    
class CommsDetailViewController: UIViewController, Storyboarded {
    
    let dummyData: [String: Any] = [
        "id": 123456,
        "title": "This is a title.",
        "tag": "covid-19",
        "description": "This is a description"
    ]
    
    @IBOutlet weak var commsScrollView: UIScrollView!
    @IBOutlet weak var commsImageView: UIImageView!
    @IBOutlet weak var commsLabelView: UILabel!
    @IBOutlet weak var commsDescriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commsScrollView.refreshControl = UIRefreshControl()
        commsScrollView.refreshControl?.addTarget(self, action:
                                           #selector(handleRefreshControl),
                                           for: .valueChanged)

    }
    
    @objc func handleRefreshControl() {
       // Update your content…

       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.commsScrollView.refreshControl?.endRefreshing()
       }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
