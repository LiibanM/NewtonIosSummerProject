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
    var user: NewUser!
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
     let searchBarScopeIsFiltering =
         searchController.searchBar.selectedScopeButtonIndex != 0
       return searchController.isActive &&
         (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    var topCategories = [String]()
    var allCategories = [String]()
    
    var selectedOtherCategory: String!
    var otherCategories = [String]()
    
    var refreshControl: UIRefreshControl!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.isHidden = true
        pickerView.backgroundColor = .white
        pickerView.alpha = 1
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                   registerForPreviewing(with: self, sourceView: view)
        }
        refreshControl = UIRefreshControl()
        commsListTableView.dataSource = self
        commsListTableView.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self

        commsListTableView.register(UINib.init(nibName: Constants.Comms.commsCellNibName, bundle: nil), forCellReuseIdentifier: Constants.Comms.commsCellIdentifier )
        
        self.navigationItem.title = "Comms"
        
        if user.permissionLevel == "admin" {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: nil)
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search comms"
//        definesPresentationContext = true
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
        
        commsListPresenter.loadData()
        
        if #available(iOS 10.0, *) {
            commsListTableView.refreshControl = refreshControl
        } else {
            commsListTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(getCommsData), for: .valueChanged)
                
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
        
        if category == "..." {
            pickerView.isHidden = false
            searchController.searchBar.endEditing(true)
            chosenCategory = selectedOtherCategory
        } else {
            pickerView.isHidden = true
        }
        let doesCategoryMatch = (chosenCategory == "All") || comm.articleCategories[0].category.categoryName == chosenCategory

        if isSearchBarEmpty {
            return doesCategoryMatch
        } else {
            return doesCategoryMatch && comm.title!.lowercased().contains(searchText.lowercased())
        }
        
      }
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
        DispatchQueue.main.async {
            self.allCategories = data
            self.allCategories.append("...")
            self.allCategories.insert("All", at: 0)
            self.topCategories = Array(self.allCategories[0...1])
            self.topCategories.append("...")
            self.calculateOtherCategories()
            self.searchController.searchBar.scopeButtonTitles = self.topCategories
            self.pickerView.reloadComponent(0)
        }
    }
    
    func setCommsData(with data: [Article]) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.comms = data
            self.commsListTableView.reloadData()
        }
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

        cell.commsCategoryLabel.setTitle(currentComms.articleCategories[0].category.categoryName, for: .normal)
        cell.downLoadImage(from: currentComms.picture ?? "")
        cell.highlightedImageView.isHidden = !currentComms.highlighted
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if user.permissionLevel == "admin" {

            let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
                let swipedComm = self.isFiltering ? self.filteredComms[indexPath.row] : self.comms[indexPath.row]
                let id = swipedComm.articleID
                self.commsListPresenter.didSwipeEdit(with: id)
                completionHandler(true)
            }
            
            edit.image = UIImage(systemName: "pencil")
            edit.backgroundColor = UIColor(red: 239/255, green: 108/255, blue: 0, alpha: 1)
            
            let swipe = UISwipeActionsConfiguration(actions: [edit])
            return swipe
        }
        return nil
    }
    
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if user.permissionLevel == "admin" {
            let highlight = UIContextualAction(style: .normal, title: "Highlight") { (action, view, completionHandler) in
                let swipedComm = self.isFiltering ? self.filteredComms[indexPath.row] : self.comms[indexPath.row]
                let id = swipedComm.articleID
                self.commsListPresenter.highlightComm(with: id)
                completionHandler(true)
            }
            
            highlight.image = UIImage(systemName: "star")
            highlight.backgroundColor = UIColor(red: 124/255, green: 58/255, blue:175/255, alpha: 1)
            
            let swipe = UISwipeActionsConfiguration(actions: [highlight])
            return swipe
        }
        return nil
    }
}

extension CommsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tappedComm = isFiltering ? filteredComms[indexPath.row] : comms[indexPath.row]
        let id = tappedComm.articleID
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

extension CommsListViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

           if let indexPath = commsListTableView.indexPathForRow(at: location) {
            previewingContext.sourceRect = commsListTableView.rectForRow(at: indexPath)
            let tappedComm = isFiltering ? filteredComms[indexPath.row-1] : comms[indexPath.row-1]
            let id = tappedComm.articleID
            let vc = commsListPresenter.previewCommsDetail(with: id)
            return vc
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
       navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}


