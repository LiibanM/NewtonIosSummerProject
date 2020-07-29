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
    
    var keychainService: KeychainSwift // This should be a Protocol
    // should be a let because setting in the init and not changing
    
    var userToken: Any! // This should be an optional & also a let
    
    var apiService: ApiServiceProtocol // Should be a let because setting in the init and not changing
    
    init(_ navigationController: UINavigationController) {
        self.apiService = ApiService()
        self.keychainService = KeychainSwift()
        self.userToken = self.keychainService.get("userToken")
        super.init(navigationController: navigationController)
        self.navigationController.navigationBar.isHidden = true
    }
    
    override func start() {
        
        //
        // if let userToken = userToken {
        //  code
        // }
        // else {
        //  code
        // }
        //
        // Use if let/guard let to unwrap optionals safely and don't have to perform the != nil check
        
        if userToken != nil {
            print(userToken!)
            showComms()
            return // Can remove this, you have it wrapped in if else so else will not run
        } else {
            showLogin()
            return // Can remove this, you have it wrapped in if else so else will not run
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

