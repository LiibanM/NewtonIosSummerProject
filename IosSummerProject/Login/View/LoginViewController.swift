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
            loginPresenter.didLogin()
        }
        
        loginPresenter.googleSharedSignIninitialSetup()
        
        let gSignIn = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 230, height: 48))
        gSignIn.center = view.center
        view.addSubview(gSignIn)
        
    }

}

extension LoginViewController: LoginPresenterView {
    func errorOccurred(message: String) {
        print("Error")
    }
    
    
}
