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
        showCommsDetail()
    }
    
    func showCommsList() {
        let commsListViewController = CommsListViewController.instantiate(storyboard: "CommsList")
        let commsListPresenter = CommsListPresenter(with: commsListViewController, delegate: self)
        commsListViewController.commsListPresenter = commsListPresenter
        self.navigationController.viewControllers = [commsListViewController]
    }
    
    func showCommsDetail() {
        let commsDetailViewController = CommsDetailViewController.instantiate(storyboard: "CommsDetail")
        self.navigationController.viewControllers = [commsDetailViewController]
    }
    
}

extension CommsCoordinator: CommsListPresenterDelegate {

}
