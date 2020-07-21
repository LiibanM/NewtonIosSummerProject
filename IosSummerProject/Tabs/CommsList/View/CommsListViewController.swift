//
//  CommsListViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit
import Kingfisher

class CommsListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var commsListTableView: UITableView!
    var commsListPresenter: CommsListPresenterProtocol!
    
    var comms = [Article]()
    private let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commsListTableView.dataSource = self
        commsListTableView.delegate = self

        commsListTableView.register(UINib.init(nibName: Constants.Comms.commsCellNibName, bundle: nil), forCellReuseIdentifier: Constants.Comms.commsCellIdentifier )
        
        self.navigationItem.title = "Comms"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        commsListPresenter.loadData()
        
        if #available(iOS 10.0, *) {
            commsListTableView.refreshControl = refreshControl
        } else {
            commsListTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(getCommsData), for: .valueChanged)
        
        
    }
    
    @objc func addButtonTapped() {
        commsListPresenter.didTapAddComms()
    }
    
    @objc func getCommsData() {
        commsListPresenter.loadData()
    }
    

}

extension CommsListViewController: CommsListPresenterView {
    func setCommsData(with data: [Article]) {
        self.refreshControl.endRefreshing()
        comms = data
        self.commsListTableView.reloadData()

    }
    
    func errorOccured(message: String) {
        self.refreshControl.endRefreshing()
        print(message)
    }
    
    
}

extension CommsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Comms.commsCellIdentifier, for: indexPath) as! CommsCell
        let currentComms = comms[indexPath.row]
        
                
        cell.commsTitleLabel.text = currentComms.title
        cell.commsCategoryLabel.text = currentComms.content
        cell.downLoadImage(from: currentComms.image)
        
        return cell
        
    }
    
}

extension CommsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
    }
}



