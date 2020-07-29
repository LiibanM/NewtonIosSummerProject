//
//  LoginPresenter.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import GoogleSignIn
import UIKit
import KeychainSwift

protocol LoginPresenterView {
    func errorOccured(message: String)
}

protocol LoginPresenterDelegate {
    func didLogin()
}

class LoginPresenter: NSObject, LoginPresenterProtocol {
    
    let view: LoginPresenterView
    let delegate: LoginPresenterDelegate
    var keychainService: KeychainSwift
    var apiService: ApiServiceProtocol
    
    //PH Function pull user from database
    func getUser() -> String?{
        //get user from db / check if user is present in db
        return nil
    }

    func postUser(user: User) {
        //Post user to db
    }
    
    init(with view: LoginPresenterView, delegate: LoginPresenterDelegate, _ keychainService: KeychainSwift, _ apiService: ApiServiceProtocol) {
        self.apiService = apiService
        self.keychainService = keychainService
        self.view = view
        self.delegate = delegate
        
    }
    
//    func didLogin(with user: Any) {
//        delegate.didLogin(with user: Any)
//    }
    
    func createGoogleSharedInstance() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = view as? UIViewController
    }
}

extension LoginPresenter: GIDSignInDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        // Prints out credentials for testing purposes
        //TODO: to be removed before launch
        
        apiService.sendData(url: "", payload: user.authentication.idToken) { (result) in
            switch result {
                case .failure(.badUrl):
                    self.view.errorOccured(message: "Given Url was bad")
                case .failure(.failedToDecode):
                    self.view.errorOccured(message: "Failed to decode data" )
                case .failure(.requestFailed):
                    self.view.errorOccured(message: "request failed")
                case .failure(.unAuthenticated):
                    self.view.errorOccured(message: "Unauthenticated" )
                case .success(let userJwtToken):
                    self.keychainService.set(userJwtToken!, forKey: "userToken")
                    self.delegate.didLogin()
                    print("Success")
                default:
                    self.view.errorOccured(message: "error")
            }
        }
//        delegate.didLogin()
//        keychainService.set(idToken!, forKey: "userToken")
    }
    /*func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("user has disconnected")
    }*/
}

