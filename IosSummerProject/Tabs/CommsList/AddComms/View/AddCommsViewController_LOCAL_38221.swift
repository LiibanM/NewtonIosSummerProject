//
//  AddCommsViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class AddCommsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var commsTitle: UITextField!
    @IBOutlet weak var commsContent: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendComms(_ sender: Any) {
        guard  let title = commsTitle.text else {print("No Tittle"); return}
        guard let content = commsContent.text else {print("No description"); return}
        
        let comms = CommsContent(title:title, description: content)
        
        let postRequest = APIRequest(endpoint: "Addcomms")
        
        postRequest.save(comms, completion: { result in
            switch result{
            case .success:
                print("the following message has been sent")
            case .failure:
               print("an error occured when sending")
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
