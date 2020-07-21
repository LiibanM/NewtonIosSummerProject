//
//  AppCoordinator.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var commsCoordinator: CommsCoordinator!
    var loginCoordinator: LoginCoordinator!
    
    init(_ navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        showLogin()
    }
    
    func showLogin() {
        loginCoordinator = LoginCoordinator(
            navigationController,
            delegate: self)
        
        self.addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
    }
    
    func showComms() {
        commsCoordinator = CommsCoordinator(navigationController, delegate: self)
        addChildCoordinator(commsCoordinator)
        commsCoordinator.start()
    }
}

extension AppCoordinator: CommsCoordinatorDelegate {
    
}

extension AppCoordinator: LoginCoordinatorDelegate {
    func didLogin() {
        self.removeChildCoordinator(loginCoordinator)
        showComms()
    }
}

