//
//  CustomAlert.swift
//  IosSummerProject
//
//  Created by Nikola Drangovski on 21/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit
class CustomAlert {
    
     init(){}
    
    func showAllert(title:String,
                    message:String,
                    okButtonText:String,
                    cancelButtonText:String,
                    viewController:UIViewController,
                    completion: @escaping (_ res: Bool?) -> ()
    ){
        
        let customAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        customAlert.addAction(UIAlertAction(title: okButtonText, style: .default, handler: { (action: UIAlertAction!) in
            completion(true)
        }))

        customAlert.addAction(UIAlertAction(title: cancelButtonText, style: .cancel, handler: { (action: UIAlertAction!) in
            completion(false)
        }))

        viewController.present(customAlert, animated: true, completion: nil)
    }

}
