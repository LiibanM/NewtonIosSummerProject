//
//  EditCommsViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 26/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class EditCommsViewController: UIViewController, Storyboarded {
    
    var editCommsPresenter: EditCommsPresenterProtocol!
    var comm: Article!

    override func viewDidLoad() {
        super.viewDidLoad()
        editCommsPresenter.loadComm()
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

extension EditCommsViewController: EditCommsPresenterView {
    func setCommsData(with article: Article) {
        comm = article
        print(comm, "edit")
    }
    
    func errorOccured(message: String) {
        print(message)
    }
    
    
}
