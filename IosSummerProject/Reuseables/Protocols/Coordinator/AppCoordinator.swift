//
//  AppCoordinator.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

class AppCoordinator: Coordinator {
    
    var commsCoordinator: CommsCoordinator!
    var loginCoordinator: LoginCoordinator!
    
    let keychainService: KeychainSwift!
    
    let userToken: Any?
    
    let apiService: ApiServiceProtocol
    
    init(_ navigationController: UINavigationController) {
        self.apiService = ApiService()
        self.keychainService = KeychainSwift()
        self.userToken = self.keychainService.get("userToken")
        super.init(navigationController: navigationController)
        self.navigationController.navigationBar.isHidden = true
    }
    
    override func start() {
        
        if let userToken = userToken {
            print(userToken)
            showComms()
            
        } else {
            showLogin()
        }
        
    }
    
    func showLogin() {
        loginCoordinator = LoginCoordinator(navigationController, delegate: self, keychainService)
        
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

