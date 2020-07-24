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
