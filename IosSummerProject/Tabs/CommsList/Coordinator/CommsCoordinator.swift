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
//    func didSelectPost()
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
        self.navigationController.viewControllers = [commsListViewController]
    }
    
    func showAddComms() {
        
    }
    
}

extension CommsCoordinator: CommsListPresenterDelegate {

}
