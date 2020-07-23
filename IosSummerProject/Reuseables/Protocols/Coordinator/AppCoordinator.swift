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
    
    var apiService: ApiServiceProtocol
    
    init(_ navigationController: UINavigationController) {
        self.apiService = ApiService()
        super.init(navigationController: navigationController)
        self.navigationController.navigationBar.isHidden = true

    }
    
    override func start() {
        showLogin()
    }
    
    func showLogin() {
        loginCoordinator = LoginCoordinator(navigationController, delegate: self)
        
        self.addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
    }
    
    func showComms() {
        self.navigationController.navigationBar.isHidden = false
        commsCoordinator = CommsCoordinator(navigationController, delegate: self, apiService)
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

