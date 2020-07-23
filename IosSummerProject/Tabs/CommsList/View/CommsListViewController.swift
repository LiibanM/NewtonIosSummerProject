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
    
    @IBOutlet weak var pickerViewOverlay: UIView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var commsListTableView: UITableView!
    
    var commsListPresenter: CommsListPresenterProtocol!
    var searchController: UISearchController!
    var comms = [Article]()
    var filteredComms = [Article]()
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
     let searchBarScopeIsFiltering =
         searchController.searchBar.selectedScopeButtonIndex != 0
       return searchController.isActive &&
         (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    let categories = ["All", "Business Updates", "COVID-19", "Random", "Other"]
    let allCategories = ["Business Updates", "COVID-19", "Random", "Other", "Tech", "AND"]
    var otherCategories = [String]()
    
    private let refreshControl = UIRefreshControl()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.isHidden = true
        pickerView.backgroundColor = .white
        pickerView.alpha = 1
        pickerViewOverlay.isHidden = true
        
        commsListTableView.dataSource = self
        commsListTableView.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self

        commsListTableView.register(UINib.init(nibName: Constants.Comms.commsCellNibName, bundle: nil), forCellReuseIdentifier: Constants.Comms.commsCellIdentifier )
        
        self.navigationItem.title = "Comms"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search comms"
//        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = categories
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
        
        commsListPresenter.loadData()
        
        if #available(iOS 10.0, *) {
            commsListTableView.refreshControl = refreshControl
        } else {
            commsListTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(getCommsData), for: .valueChanged)
        
        calculateOtherCategories()
        
    }
    
    func arrayToSet<T>(_ x: [T]) -> Set<T> {
        return Set(x)
    }
    
    func differenceBetweenSets<T>(_ x: Set<T>, _ y: Set<T>) -> Set<T> {
        return y.subtracting(x)
    }
    
    func setToArray<T>(_ x: Set<T>) -> [T] {
        return Array(x)
    }
    
    func calculateOtherCategories() {
        let setOfAllCategories = arrayToSet(allCategories)
        let setOfTopCategories = arrayToSet(categories)
        let difference = differenceBetweenSets(setOfTopCategories, setOfAllCategories)
        otherCategories = setToArray(difference)
    }
    
    
    func filterContentForSearchText(_ searchText: String,
                                    category: String? = nil) {
      filteredComms = comms.filter { (comm: Article) -> Bool in
        
        if category == "Other" {
            pickerView.isHidden = false
            searchController.searchBar.endEditing(true)

        } else {
            pickerView.isHidden = true
        }
        let doesCategoryMatch = (category == "All") || comm.category.category_name == category

        if isSearchBarEmpty {
            return doesCategoryMatch
        } else {
            return doesCategoryMatch && comm.title.lowercased().contains(searchText.lowercased())
        }
        
      }
      print(filteredComms)
      commsListTableView.reloadData()
    }
    

    @IBAction func categoryButtonTapped(_ sender: Any) {
        if pickerView.isHidden {
            pickerView.isHidden = false
            pickerViewOverlay.isHidden = false
        }
    }
    
    @objc func addButtonTapped(_ sender: Any) {
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
        if isFiltering {
            return filteredComms.count
        }
        return comms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Comms.commsCellIdentifier, for: indexPath) as! CommsCell
        
        let currentComms: Article
        
        if isFiltering {
            currentComms = filteredComms[indexPath.row]
        } else {
            currentComms = comms[indexPath.row]
        }
        
        cell.commsTitleLabel.text = currentComms.title
        cell.commsCategoryLabel.text = "\(currentComms.date)"
        cell.downLoadImage(from: currentComms.image)
        cell.highlightedTextLabel.text = currentComms.highlighted ? "Highlighted" : ""
        
        
        return cell
    }
    
}

extension CommsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tappedComm = comms[indexPath.row]
        let id = tappedComm.article_id
        searchController.searchBar.endEditing(true)
        commsListPresenter.didTapComm(with: id)

    }
}

extension CommsListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return otherCategories.count
    }
    
    
}

extension CommsListViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return otherCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryButton.setTitle(otherCategories[row], for: .normal)
        pickerView.isHidden = true
        pickerViewOverlay.isHidden = true
    }
    
}

extension CommsListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
      let searchBar = searchController.searchBar
      filterContentForSearchText(searchBar.text!, category: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    }
}

extension CommsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
         selectedScopeButtonIndexDidChange selectedScope: Int) {
//       let category = Candy.Category(rawValue:
//         searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, category: searchBar.scopeButtonTitles![selectedScope])
     }
}



