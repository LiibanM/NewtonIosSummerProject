//
//  EditCommsViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 26/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit
import Kingfisher

class EditCommsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var editCommsCategory: UILabel!
    @IBOutlet weak var editCommsImage: UIImageView!
    @IBOutlet weak var editCommsDescription: UITextView!
    
    var editCommsPresenter: EditCommsPresenterProtocol!
    var comm: Article!
    
    var editCommsTitle: UITextView!
    var titleView:UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEditableFields()
        
        let rect:CGRect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: 200, height: 70))
        
        titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
       
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 20))
        titleLabel.textAlignment = .center
        titleLabel.text = "Title:"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        
        editCommsTitle = UITextView(frame: CGRect(x: 0, y: 10, width: 200, height: 70))
        editCommsTitle.textContainer.maximumNumberOfLines = 1
        editCommsTitle.text = comm.title
        editCommsTitle.font = UIFont.boldSystemFont(ofSize: 15)
        editCommsTitle.backgroundColor = .none
        editCommsTitle.textAlignment = .center
        titleView.addSubview(editCommsTitle)
        
       
        titleView.addSubview(titleLabel)
        
        navigationItem.titleView = titleView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEdittedCommTapped))

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func saveEdittedCommTapped() {
        editCommsPresenter.didTapSave(for: comm)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        editCommsDescription.resignFirstResponder()
        editCommsTitle.resignFirstResponder()
    }
    
    func setUpEditableFields() {
        editCommsPresenter.loadComm()
        editCommsCategory.text = comm.category.category_name
        guard let url = URL(string: comm.image) else {
            print("bad url")
            return
        }
        editCommsImage.kf.setImage(with: url)
        editCommsDescription.isEditable = true
        editCommsDescription.layer.borderWidth = 1
        editCommsDescription.layer.borderColor =  UIColor.lightGray.cgColor
        editCommsDescription.layer.cornerRadius = 5
//        editCommsDescription.layer.backgroundColor = UIColor.lightGray.cgColor
        editCommsDescription.text = comm.content
    }
    
    @IBAction func editCommsImageTapped(_ sender: Any) {
        showImagePickerControllerActionSheet()
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


extension EditCommsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerControllerActionSheet() {
        let alert =  UIAlertController(title: "Choose your image", message: nil, preferredStyle: .actionSheet)

        let photoLibraryAction = UIAlertAction(title: "Choose from library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        
        let cameraAction = UIAlertAction(title: "Take from camera", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)


        self.present(alert, animated: true, completion: nil)
//        alert.addAction(cameraAction)
//        alert.addAction(cancelAction)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            editCommsImage.image = editedImage
            let imageData = editedImage.pngData()
            print(imageData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters))
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            editCommsImage.image = originalImage
        }

        dismiss(animated: true, completion: nil)
    }
}
