//
//  LoginViewController.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, Storyboarded {
    
    var loginPresenter: LoginPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (GIDSignIn.sharedInstance().hasPreviousSignIn()){
//            loginPresenter.didLogin()
        }
        
        loginPresenter.createGoogleSharedInstance()
        
        createGoogleSignInButton()
        
    }
    
    func createGoogleSignInButton() {
        let gSignIn = GIDSignInButton()
        gSignIn.style = GIDSignInButtonStyle.wide
        gSignIn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gSignIn)
        gSignIn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gSignIn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

extension LoginViewController: LoginPresenterView {
    func errorOccurred(message: String) {
        print("Error")
    }
    
    
}
