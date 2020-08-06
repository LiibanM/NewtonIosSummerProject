//
//  CustomAlert.swift
//  IosSummerProject
//
//  Created by Nikola Drangovski on 21/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

class CustomActionSheet {
    
    // An AlertViewController has a .actions array which you can hook into to add as many actions as you want
    
    // By passing an array of actionTitles and actions of type [((UIAlertAction) -> Void?] you can create and add these actions to an alertviewcontroller
    
    // ---- EXAMPLE ----
    
    //    func showCustomAlert(view: UIViewController, title: String, message: String, actionTitles:[String?], actions: [((UIAlertAction) -> Void)?]) {
    //
    //           let alert = UIAlertController(
    //               title: title,
    //               message: message,
    //               preferredStyle: UIAlertController.Style.alert)
    //
    //           for (index, title) in actionTitles.enumerated() {
    //               let action = UIAlertAction(
    //                   title: title,
    //                   style: .default,
    //                   handler: actions[index])
    //
    //               alert.addAction(action)
    //           }
    //    }
    
     init(){}
    
    //FILIP: Unsure how to implement this and how scalable it makes it due to the fixed set of custom erros that we have / will have
   /* func showCustomAlert(view: UIViewController, title: String, message: String, optionOne: String,
                         optionTwo: String, actionTitles:[String?], actions: [((UIAlertAction) -> Void)?]) {
        
        let customAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        for (index, title) in actionTitles.enumerated() {
            let actionOne = UIAlertAction(
                title: optionOne,
                style: .default,
                handler: actions[index])
            customAlert.addAction(actionOne)
            
            let actionTwo = UIAlertAction(
                title: optionTwo,
                style: .default,
                handler: actions[index])
            customAlert.addAction(actionTwo)
            
            let actionCancel = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: actions[index])
            customAlert.addAction(actionCancel)
        }
        
    }*/
    
    func showAlert(title: String,
                    message: String,
                    optionOne: String,
                    optionTwo: String,
                    viewController: UIViewController,
                    completion: @escaping (_ res: String?) -> ()
    ){
        
        let customAlert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        customAlert.addAction(UIAlertAction(title: optionOne, style: .default, handler: { (action: UIAlertAction!) in
            completion(optionOne)
        }))
        
        customAlert.addAction(UIAlertAction(title: optionTwo, style: .default, handler: { (action: UIAlertAction!) in
            completion(optionTwo)
        }))
        
        customAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) -> Void in
                
        }))
    
        
        viewController.present(customAlert, animated: true, completion: nil)
    }

}
