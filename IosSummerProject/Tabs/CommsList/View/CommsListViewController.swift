//
//  CommsListViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class CommsListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var commsListTableView: UITableView!
    var commsListPresenter: CommsListPresenterProtocol!
    
    var comms = ["hello"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commsListTableView.dataSource = self
        
        commsListTableView.delegate = self
        
        commsListTableView.register(UINib.init(nibName: Constants.Comms.commsCellNibName, bundle: nil), forCellReuseIdentifier: Constants.Comms.commsCellIdentifier )
        self.navigationItem.title = "Comms"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func addButtonTapped(sender: UIBarButtonItem) {
        commsListPresenter.didTapAddComms()
    }
    

}

extension CommsListViewController: CommsListPresenterView {
    func setCommsData(with data: [Article]) {
//        comms = data
    }
    
    func errorOccured(message: String) {
        print(message)
    }
    
    
}

extension CommsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Comms.commsCellIdentifier, for: indexPath) as! CommsCell
        
        cell.commsTitleLabel.text = "Kash Money"
        cell.commsCategoryLabel.text = "Awesome"
        return cell
        
    }
}

extension CommsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
    }
}



