//
//  CommsCoordinator.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

protocol CommsCoordinatorDelegate {
}

class CommsCoordinator: Coordinator {
    
    var apiService: ApiServiceProtocol
    var addCommsViewController: AddCommsViewController
    init(_ navigationController: UINavigationController, delegate: CommsCoordinatorDelegate, _ apiService: ApiServiceProtocol) {
        
        self.apiService = apiService
        addCommsViewController = AddCommsViewController.instantiate(storyboard: "AddComms")
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        showCommsList()
    }
    
    func showCommsList() {
        let commsListViewController = CommsListViewController.instantiate(storyboard: "CommsList")
        let commsListPresenter = CommsListPresenter(with: commsListViewController, delegate: self, apiService)
        commsListViewController.commsListPresenter = commsListPresenter
        self.navigationController.viewControllers = [UIViewController]()
        navigationController.pushViewController(commsListViewController, animated: false)
        navigationController.navigationBar.prefersLargeTitles = true

    }
    
    func showCommsDetail(_ id: Int) {
        let commsDetailViewController = CommsDetailViewController.instantiate(storyboard: "CommsDetail")
        let commsDetailPresenter = CommsDetailPresenter(with: commsDetailViewController, delegate: self, apiService)
        commsDetailViewController.commsDetailPresenter = commsDetailPresenter
        commsDetailPresenter.articleId = id;
        self.navigationController.pushViewController(commsDetailViewController, animated: true)
    }
    
    func showAddComms() {
        let addCommsPresenter = AddCommsPresenter(with: addCommsViewController, delegate: self)
        addCommsViewController.addCommsPresenter = addCommsPresenter
        self.navigationController.pushViewController(addCommsViewController, animated: true)
    }
    
    func showCategories() {
        let showCategoriesViewController = ShowCategoriesViewController.instantiate(storyboard: "ShowCategories")
        let showCategoriesPresenter = ShowCategoriesPresenter(with: showCategoriesViewController, delegate: self, apiService)
        showCategoriesViewController.showCategoriesPresenter = showCategoriesPresenter
        self.navigationController.showDetailViewController(showCategoriesViewController, sender: nil)
        
        
    }
}

extension CommsCoordinator: CommsListPresenterDelegate {
    func goToEditComms(_ id: Int) {
        // showEditComms()
    }
    
    func goToCreateContent() {
        showAddComms()
    }
    
    func goToCommsDetail(_ id: Int) {
        showCommsDetail(id)
    }
}

extension CommsCoordinator: AddCommsPresenterDelegate {
    func goToShowCategories() {
        showCategories()
    }
    
    func goToCommsList() {
        showCommsList()
        
    }
}

extension CommsCoordinator: CommsDetailPresenterDelegate {
    
}

extension CommsCoordinator: ShowCategoriesPresenterDelegate {
    func didSelectCategory(with category: Category) {
        navigationController.dismiss(animated: true) {
            self.addCommsViewController.addCommsPresenter.selectedCategory(category)
    }
  }
    
}
