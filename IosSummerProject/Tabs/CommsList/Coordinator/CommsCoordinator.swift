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
    var editViewController: EditCommsViewController
    
    var modalDisplayedOn: String!
    
    init(_ navigationController: UINavigationController, delegate: CommsCoordinatorDelegate, _ apiService: ApiServiceProtocol) {
        
        self.apiService = apiService
        addCommsViewController = AddCommsViewController.instantiate(storyboard: "AddComms")
        editViewController = EditCommsViewController.instantiate(storyboard: "EditComms")
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
    
    
    
    func showCommsDetail(_ id: Int){
        let commsDetailViewController = CommsDetailViewController.instantiate(storyboard: "CommsDetail")
        let commsDetailPresenter = CommsDetailPresenter(with: commsDetailViewController, delegate: self, apiService)
        commsDetailViewController.commsDetailPresenter = commsDetailPresenter
        commsDetailPresenter.articleId = id;
        navigationController.navigationBar.prefersLargeTitles = false

        self.navigationController.pushViewController(commsDetailViewController, animated: true)
    }
    
    func showPreviewCommsDetail(_ id: Int) -> UIViewController {
        let commsDetailViewController = CommsDetailViewController.instantiate(storyboard: "CommsDetail")
        let commsDetailPresenter = CommsDetailPresenter(with: commsDetailViewController, delegate: self, apiService)
               commsDetailViewController.commsDetailPresenter = commsDetailPresenter
        commsDetailPresenter.articleId = id;
        navigationController.navigationBar.prefersLargeTitles = false
        return commsDetailViewController
    }
    
    func showAddComms() {
        let addCommsPresenter = AddCommsPresenter(with: addCommsViewController, delegate: self, apiService)
        addCommsViewController.addCommsPresenter = addCommsPresenter
        self.navigationController.pushViewController(addCommsViewController, animated: true)
    }
    
    func showCategories() {
        let showCategoriesViewController = ShowCategoriesViewController.instantiate(storyboard: "ShowCategories")
        let showCategoriesPresenter = ShowCategoriesPresenter(with: showCategoriesViewController, delegate: self, apiService)
        showCategoriesViewController.showCategoriesPresenter = showCategoriesPresenter
        self.navigationController.showDetailViewController(showCategoriesViewController, sender: nil)
        
        
    }
    func showEditComms(with id: Int?, or article: Article?) {
        editViewController = EditCommsViewController.instantiate(storyboard: "EditComms")

        let editCommsPresenter = EditCommsPresenter(with: editViewController, delegate: self, apiService)
        if let passedId = id {
            editCommsPresenter.articleId = passedId
        }
        if let passedArticle = article {
             editCommsPresenter.comm = passedArticle
        }
        editViewController.editCommsPresenter = editCommsPresenter
        self.navigationController.pushViewController(editViewController, animated: true)

    }
    
}

extension CommsCoordinator: CommsListPresenterDelegate {
    func goToEditComms(_ id: Int) {
        showEditComms(with: id, or: nil)
    }
    
    func goToCreateContent() {
        showAddComms()
    }
    
    func goToCommsDetail(_ id: Int) {
        showCommsDetail(id)
    }
    
    func getCommsDetail(with id: Int) -> UIViewController {
        print("articleId", id)
        return showPreviewCommsDetail(id)
    }
}

extension CommsCoordinator: AddCommsPresenterDelegate {
    func goToShowCategories(currentPage: String) {
        modalDisplayedOn = currentPage

        showCategories()
    }
    
    func goToCommsList() {
        showCommsList()
        
    }
}

extension CommsCoordinator: CommsDetailPresenterDelegate {
    func goToEditComms(_ article: Article) {
        showEditComms(with: nil, or: article)
    }
    
}

extension CommsCoordinator: ShowCategoriesPresenterDelegate {
    func didSelectCategory(with category: Category) {
        navigationController.dismiss(animated: true) {
            if self.modalDisplayedOn == "add" {
            self.addCommsViewController.addCommsPresenter.selectedCategory(category)
            } else {
                self.editViewController.editCommsPresenter.selectedCategory(with: category)
            }
    }
  }
}
    
extension CommsCoordinator: EditCommsPresenterDelegate {
    func goToCategoriesFromEdit(currentPage: String) {
        modalDisplayedOn = currentPage
        showCategories()
    }
    
    func goToCommsListAfterSave() {
        showCommsList()
    }
}
