//
//  CustomAlert.swift
//  IosSummerProject
//
//  Created by Nikola Drangovski on 21/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

// Spacing in this file needs to be sorted
// Convention should be 'param: Object type' with a space between the ':' and 'object type'
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
    
    func showAlert(title:String,
                    message:String,
                    optionOne:String,
                    optionTwo:String,
                    viewController:UIViewController,
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
