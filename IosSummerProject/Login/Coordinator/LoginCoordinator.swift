//
//  LoginCoordinator.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

protocol LoginCoordinatorDelegate {
    func didLogin()
}

class LoginCoordinator: Coordinator {
    
    var delegate: LoginCoordinatorDelegate!
    var keychainService: KeychainSwift
    
    init(_ navigationController: UINavigationController, delegate: LoginCoordinatorDelegate, _ keychainService: KeychainSwift) {
        
        self.keychainService = keychainService
        super.init(navigationController: navigationController)
        self.delegate = delegate
    }
    
    override func start() {
        showLogin()
    }
    
    func showLogin() {
        let loginViewController = LoginViewController.instantiate(storyboard: "Login")
        
        let loginPresenter = LoginPresenter(with: loginViewController, delegate: self, keychainService)
        
        loginViewController.loginPresenter = loginPresenter
        
        self.navigationController.viewControllers = [loginViewController]
    }
    
}

extension LoginCoordinator: LoginPresenterDelegate {
    func didLogin() {
        delegate.didLogin()
    }
}
