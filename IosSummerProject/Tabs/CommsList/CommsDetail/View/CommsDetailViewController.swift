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
    @IBOutlet weak var commsLabelView: UILabel!
    @IBOutlet weak var commsDescriptionView: UITextView!
    
    var commsDetailPresenter: CommsDetailPresenterProtocol!
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
        
        self.commsImageView.downloaded(from: image)
        self.navigationItem.title = title
        self.commsLabelView.text = tag.category_name
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
        commsDetailPresenter.didTapEdit(on: comm)
       }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        commsImageView.kf.setImage(with: url)
//        print("Download Started")
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() { [weak self] in
//                self?.commsImageView.image = UIImage(data: data)
//            }
//        }
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

extension CommsDetailViewController: CommsDetailPresenterView {
    func errorOccured(message: String) {
        print(message)
    }
    
    func setCommsData(with data: Article) {
        comm = data
    }
}
