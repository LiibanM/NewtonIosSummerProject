//
//  EditCommsViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 26/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class EditCommsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var editCommsCategory: UILabel!
    @IBOutlet weak var editCommsImage: UIImageView!
    @IBOutlet weak var editCommsDescription: UITextView!
    
    var editCommsPresenter: EditCommsPresenterProtocol!
    var comm: Article!
    
    var editCommsTitle: UITextField!
    var titleView:UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEditableFields()
        
        
        navigationItem.titleView = UITextView()

//        let titleView = UIView()
//        let textArea = UITextView(frame: CGRect())
//        titleView.addSubview(textArea)
        let rect:CGRect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: 64, height: 64))
            
        titleView = UIView.init(frame: rect)
       
        editCommsTitle = UITextField.init(frame: CGRect.init(x: 0, y: 30, width: 64, height: 24))
        editCommsTitle.text = comm.title
        editCommsTitle.font = UIFont.systemFont(ofSize: 12)
        editCommsTitle.textAlignment = .center
        titleView.addSubview(editCommsTitle)
        
        navigationItem.titleView = titleView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEdittedCommTapped))

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func saveEdittedCommTapped() {
//        editCommsPresenter.saveEdittedComm()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        navigationItem.titleView?.resignFirstResponder()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        editCommsDescription.resignFirstResponder()
        editCommsTitle.resignFirstResponder()


    }
    
    func setUpEditableFields() {
        editCommsPresenter.loadComm()
        editCommsCategory.text = comm.category.category_name
        editCommsDescription.isEditable = true
        editCommsDescription.text = comm.content
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
