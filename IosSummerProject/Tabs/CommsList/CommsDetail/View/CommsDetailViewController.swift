//
//  AddCommsViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

    
class CommsDetailViewController: UIViewController, Storyboarded {
        
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
        // this is dummy data (will eventually be from backend)
        let isAdmin = true
        let image = "https://www.lifeline-security.co.uk/wp-content/uploads/2020/03/covid-19.png"
        let title = "CRT Comms"
        let tag = "Covid-19 Important Information"
        let description = "Hi Everyone, Please see the following slides detailing changes to the existing policies and processes which we have put in place to help us manage the business in the current climate we are operating in.\n\nThe slides confirm and clarify the changes mentioned by Paramjit in the last all AND call.They cover the following 3 key areas:\n\n\u{2022} Holiday Policy changes\n\u{2022} Probation Period changes\n\u{2022} Performance & Progression changes\n\nYou will be receiving some additional comms from your LoB (Line of Business) Leads explaining what follow up actions will be either required by you or put in place as a result of the changes that have been made.\n\nThank you to everyone who completed the last Illume survey. Results are being analysed so we can fully understand your view and take appropriate action to continue making sure we’re looking after our ANDis. From just over 500 responses, 93% of you are feeling confident about the company and 89% are feeling positive about the way we are communicating. A big thank you for your confidence in our company and the way we are dealing with this crisis."
        
        self.commsImageView.downloaded(from: image)
        self.navigationItem.title = title
        self.commsLabelView.text = tag
        self.commsLabelView?.layer.cornerRadius = commsLabelView.frame.size.height/5.0
        self.commsLabelView?.layer.masksToBounds = true
        self.commsDescriptionView.text = description
        
        if isAdmin {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(editButtonTapped))
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
        

    }
    
    @objc func menuAction(){
        print("menu button pressed")  //Do your action here
    }
    
    @objc func handleRefreshControl() {
       // Fetch the comm data from database & update elements
       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.commsScrollView.refreshControl?.endRefreshing()
       }
    }
    
    @objc func editButtonTapped() {
           // open screen to edit comm
       }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.commsImageView.image = UIImage(data: data)
            }
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
