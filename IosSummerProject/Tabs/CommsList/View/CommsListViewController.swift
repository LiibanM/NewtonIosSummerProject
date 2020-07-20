//
//  CommsListViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class CommsListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var commsListTableView: UITableView!
    var commsListPresenter: CommsListPresenterProtocol!
    
    var comms = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension CommsListViewController: CommsListPresenterView {
    func errorOccured(message: String) {
        print(message)
    }
    
    
}

extension CommsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommsCell", for: indexPath) as! CommsCell
        
        cell.commsTitleLabel.text = "Kash Money"
        
        return cell
        
    }
    
    
}

