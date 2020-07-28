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
    
    let topCategories = ["All", "Business Updates", "COVID-19", "Random", "Other"]
    let allCategories = ["Business Updates", "COVID-19", "Random", "Other", "Tech", "AND"]
    
    var selectedOtherCategory: String!
    var otherCategories = [String]()
    
    private let refreshControl = UIRefreshControl()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.isHidden = true
        pickerView.backgroundColor = .white
        pickerView.alpha = 1
        
        commsListTableView.dataSource = self
        commsListTableView.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self

        commsListTableView.register(UINib.init(nibName: Constants.Comms.commsCellNibName, bundle: nil), forCellReuseIdentifier: Constants.Comms.commsCellIdentifier )
        
        self.navigationItem.title = "Comms"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: nil)
        searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search comms"
//        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = topCategories
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
        let setOfTopCategories = arrayToSet(topCategories)
        let difference = differenceBetweenSets(setOfTopCategories, setOfAllCategories)
        otherCategories = setToArray(difference)
    }
    
    
    func filterContentForSearchText(_ searchText: String,
                                    category: String? = nil) {
      filteredComms = comms.filter { (comm: Article) -> Bool in
        
        var chosenCategory = category
        
        if category == "Other" {
            pickerView.isHidden = false
            searchController.searchBar.endEditing(true)
            chosenCategory = selectedOtherCategory

        } else {
            pickerView.isHidden = true
        }
        let doesCategoryMatch = (chosenCategory == "All") || comm.category.category_name == chosenCategory

        if isSearchBarEmpty {
            return doesCategoryMatch
        } else {
            return doesCategoryMatch && comm.title.lowercased().contains(searchText.lowercased())
        }
        
      }
      print(filteredComms)
      commsListTableView.reloadData()
    }
    
    @objc func addButtonTapped(_ sender: Any) {
        commsListPresenter.didTapAddComms()
    }
    
    @objc func getCommsData() {
        commsListPresenter.loadData()
    }
}

extension CommsListViewController: CommsListPresenterView {
    func setAllCategories(with data: [String]) {
//        data.append("Other")
//      allCategories = data[0 ... 3]
    }
    
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
        cell.commsDescription.text = currentComms.content

        cell.commsCategoryLabel.text = currentComms.category.category_name
        cell.downLoadImage(from: currentComms.image)
        cell.highlightedImageView.isHidden = !currentComms.highlighted
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            print("edit")
            let swipedComm = self.isFiltering ? self.filteredComms[indexPath.row] : self.comms[indexPath.row]
            let id = swipedComm.article_id
            self.commsListPresenter.didSwipeEdit(with: id)
            completionHandler(true)
        }
        
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = .orange
        
        let swipe = UISwipeActionsConfiguration(actions: [edit])
        return swipe
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let highlight = UIContextualAction(style: .normal, title: "Highlight") { (action, view, completionHandler) in
            print("Highlight")
            let swipedComm = self.isFiltering ? self.filteredComms[indexPath.row] : self.comms[indexPath.row]
            let id = swipedComm.article_id
            self.commsListPresenter.highlightComm(with: id)
            completionHandler(true)
        }
        
        highlight.image = UIImage(systemName: "star")
        highlight.backgroundColor = .systemIndigo
        
        let swipe = UISwipeActionsConfiguration(actions: [highlight])
        return swipe
        
    }
}

extension CommsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tappedComm = isFiltering ? filteredComms[indexPath.row] : comms[indexPath.row]
        let id = tappedComm.article_id
        print("Article ID Controller", id)
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
        selectedOtherCategory = otherCategories[row]
        pickerView.isHidden = true
        filterContentForSearchText(searchController.searchBar.text!, category: selectedOtherCategory)
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
        filterContentForSearchText(searchBar.text!, category: searchBar.scopeButtonTitles![selectedScope])
     }
}



