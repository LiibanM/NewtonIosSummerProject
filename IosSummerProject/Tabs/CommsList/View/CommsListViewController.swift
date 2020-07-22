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
//    [{title:"hi", highlighted: true, date: yesterday}, {title:"bye", highlighted: false, date: yesterday}, {title:"hi2", highlighted: true, date: today}]
//    --->
//    [{title:"hi", highlighted: true, date: today}, {title:"hi2", highlighted: true, date: yesterday}, {title:"bye", highlighted: false, date: today}]
    
    @IBOutlet weak var pickerViewOverlay: UIView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var commsListTableView: UITableView!
    var commsListPresenter: CommsListPresenterProtocol!
    
    var comms = [Article]()
    
    let categories = ["Business Updates", "COVID-19", "Random", "Updates"]
    private let refreshControl = UIRefreshControl()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.isHidden = true

//        pickerViewOverlay.isHidden = true
        
        commsListTableView.dataSource = self
        commsListTableView.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self

        commsListTableView.register(UINib.init(nibName: Constants.Comms.commsCellNibName, bundle: nil), forCellReuseIdentifier: Constants.Comms.commsCellIdentifier )
        
        self.navigationItem.title = "Comms"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        commsListPresenter.loadData()
        
        if #available(iOS 10.0, *) {
            commsListTableView.refreshControl = refreshControl
        } else {
            commsListTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(getCommsData), for: .valueChanged)
        
        
    }
    

    @IBAction func categoryButtonTapped(_ sender: Any) {
        if pickerView.isHidden {
            pickerView.isHidden = false
//            pickerViewOverlay.isHidden = false
//            pickerViewOverlay.backgroundColor = .black
        }
        print("its me")
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
        
        cell.commsTitleLabel.text = "\(currentComms.highlighted)"
        cell.commsCategoryLabel.text = "\(currentComms.date)"
        cell.downLoadImage(from: currentComms.image)
        
        return cell
    }
    
}

extension CommsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
    }
}

extension CommsListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    
}

extension CommsListViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryButton.setTitle(categories[row], for: .normal)
        pickerView.isHidden = true
//        pickerViewOverlay.isHidden = true

    }
    
}



