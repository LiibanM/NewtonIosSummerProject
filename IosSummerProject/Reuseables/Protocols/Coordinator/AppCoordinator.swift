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
import JWTDecode
 

class AppCoordinator: Coordinator {
    
    var commsCoordinator: CommsCoordinator!
    var loginCoordinator: LoginCoordinator!
    var keychainService: KeychainSwift
    
    var userToken: String!
    
    var user: User!
    var decodedData: JWT
    
    var apiService: ApiServiceProtocol
    
    init(_ navigationController: UINavigationController) {
        self.apiService = ApiService()
        self.keychainService = KeychainSwift()
        self.userToken = self.keychainService.get("userJwtToken")
        decodedData = try! decode(jwt: userToken)
        print(decodedData, "hello")
//        user.permissionLevel = decodedData.body["http://schemas.microsoft.com/ws/2008/06/identity/claims/role"] as! String
        super.init(navigationController: navigationController)
        self.navigationController.navigationBar.isHidden = true
    }
    
    override func start() {
//        if userToken != nil {
//            showComms()
//            return
//        } else {
            showLogin()
//          return
//        }
    }
    
    func showLogin() {
        loginCoordinator = LoginCoordinator(navigationController, delegate: self, keychainService, apiService)
        
        self.addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
    }
    
    func showComms() {
        self.navigationController.navigationBar.isHidden = false
        commsCoordinator = CommsCoordinator(navigationController, delegate: self, user, apiService)
        addChildCoordinator(commsCoordinator)
        commsCoordinator.start()
    }
}

extension AppCoordinator: CommsCoordinatorDelegate {
    
}

extension AppCoordinator: LoginCoordinatorDelegate {
    
    func didLogin(with user: User) {
        self.user = user
        self.removeChildCoordinator(loginCoordinator)
        showComms()
    }
}

