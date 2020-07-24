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
    
    init(_ navigationController: UINavigationController, delegate: CommsCoordinatorDelegate, _ apiService: ApiServiceProtocol) {
        
        self.apiService = apiService
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
        let commsDetailPresenter = CommsDetailPresenter(with: commsDetailViewController, delegate: self)
        commsDetailViewController.commsDetailPresenter = commsDetailPresenter
        commsDetailPresenter.article_id = id;
        self.navigationController.pushViewController(commsDetailViewController, animated: true)
    }
    
    func showAddComms() {
        let addCommsViewController = AddCommsViewController.instantiate(storyboard: "AddComms")
        self.navigationController.pushViewController(addCommsViewController, animated: true)
        
    }
    
}

extension CommsCoordinator: CommsListPresenterDelegate {
    func goToCreateContent() {
        showAddComms()
    }
    
    func goToCommsDetail(_ id: Int) {
        showCommsDetail(id)
    }
}

extension CommsCoordinator: CommsDetailPresenterDelegate {
    
}
