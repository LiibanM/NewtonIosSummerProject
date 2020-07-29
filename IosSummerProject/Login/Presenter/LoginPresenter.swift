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
    func errorOccurred(message: String)
}

protocol LoginPresenterDelegate {
    func didLogin()
}

class LoginPresenter: NSObject, LoginPresenterProtocol {
    
    let view: LoginPresenterView
    let delegate: LoginPresenterDelegate
    var keychainService: KeychainSwift
    
    //PH Function pull user from database
    func getUser() -> String?{
        //get user from db / check if user is present in db
        return nil
    }

    func postUser(user: User) {
        //Post user to db
    }
    
    init(
        with view: LoginPresenterView,
        delegate: LoginPresenterDelegate,
        _ keychainService: KeychainSwift) {
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
        
        //need to make a call to the backend if this is successful you need to set the jwt in the keychain 
        // the app coordinator will decode the jwt by accessing the keychain and give the user to everyone

        // if(getUser() != nil /*check if userId is present in db*/){

        // } else /*user is logging into the system for the first time */{
        //     //let userId = user.userID                  // For client-side use only!
        //     let idToken = user.authentication.idToken   //TODO Send this to server ! (unwrap optional)
        //     let fullName = user.profile.name
        //     //let givenName = user.profile.givenName
        //     //let familyName = user.profile.familyName
        //     let email = user.profile.email
        //     print(fullName ?? "Can't find full name or user")
        //     print(email ?? "Can't find email of user")

        // }
        //let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken   //TODO Send this to server ! (unwrap optional)
        let fullName = user.profile.name
        //let givenName = user.profile.givenName
        //let familyName = user.profile.familyName
        let email = user.profile.email
        print(fullName ?? "Can't find full name or user")
        print(email ?? "Can't find email of user")
        print(idToken, "token")
        
        delegate.didLogin()
        keychainService.set(idToken!, forKey: "userToken")
    }
    
    /*func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("user has disconnected")
    }*/
}
