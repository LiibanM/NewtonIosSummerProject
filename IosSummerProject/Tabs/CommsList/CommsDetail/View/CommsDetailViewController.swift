//
//  AddCommsViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit
import Kingfisher

    
class CommsDetailViewController: UIViewController, Storyboarded {
            
    @IBOutlet weak var commsScrollView: UIScrollView!
    @IBOutlet weak var commsImageView: UIImageView!
    @IBOutlet weak var commsDescriptionView: UITextView!
    @IBOutlet weak var commsTagLabelButton: UIButton!
    var commsDetailPresenter: CommsDetailPresenterProtocol!
    
    // This should be stored on your CommsDetailPresenter and passed as needed through the presenter view protocol
    var comm: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commsScrollView.refreshControl = UIRefreshControl()
        commsScrollView.refreshControl?.addTarget(self, action:
                                           #selector(handleRefreshControl),
                                           for: .valueChanged)
        
        commsDetailPresenter.loadData()
        
        // this is dummy data (will eventually be from backend)
        let isAdmin = true
        let image = comm.image
        let title = comm.title
        let tag = comm.category
        let description = comm.content
        
        //self.commsImageView.downloaded(from: image)
        guard let url = URL(string: comm.image) else {
            print("bad url")
            return
        }
        self.commsImageView.kf.setImage(with: url)
        self.navigationItem.title = title
        self.commsTagLabelButton.setTitle(tag.categoryName, for: .normal)
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
        
        // Don't believe you need to call this on the main queue
       DispatchQueue.main.async {
          self.commsScrollView.refreshControl?.endRefreshing()
       }
    }
    
    @objc func editButtonTapped() {
        commsDetailPresenter.didTapEdit(on: comm)
       }
    
    // Don't know what this function is for, but, if it were to be used it should be on your presenter not your view controller
    // Your VC should only update UI, all other functionality should be dealt with on your presenter
    //FILIP: I believe it is unneccessary ?
    /*func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }*/

    // Not used
    // If downloading an image, this should be handled by your presenter and passed to the vc through presenters view protocol
    //FILIP - not required as a piece of functionality as far as I'm aware and unused
    /*func downloadImage(from url: URL) {
        commsImageView.kf.setImage(with: url)
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.commsImageView.image = UIImage(data: data)
            }
        }
    }*/
}


extension CommsDetailViewController: CommsDetailPresenterView {
    func errorOccured(message: String) {
        let alert = UIAlertController(title: "Error", message: "An unexpected error occured", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Remove alert"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        print(message)
    }
    
    func setCommsData(with data: Article) {
        comm = data
    }
}
