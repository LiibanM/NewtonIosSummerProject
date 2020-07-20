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
    
    
    init(_ navigationController: UINavigationController, delegate: CommsCoordinatorDelegate) {
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        showCommsList()
    }
    
    func showCommsList() {
        let commsListViewController = CommsListViewController.instantiate(storyboard: "CommsList")
        let commsListPresenter = CommsListPresenter(with: commsListViewController, delegate: self)
        commsListViewController.commsListPresenter = commsListPresenter
        self.navigationController.viewControllers = [commsListViewController]
    }
    
    func showAddComms() {
        
    }
    
}

extension CommsCoordinator: CommsListPresenterDelegate {

}
