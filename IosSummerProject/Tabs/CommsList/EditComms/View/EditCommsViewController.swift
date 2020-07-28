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
    
    @IBOutlet weak var editCommsCategory: UIButton!
    @IBOutlet weak var editCommsImage: UIImageView!
    @IBOutlet weak var editCommsTitle: UITextField!
    @IBOutlet weak var editCommsDescription: UITextField!
    @IBOutlet weak var editCommsHighlighted: UISegmentedControl!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var editOverlayButton: UIButton!
    
    var editCommsPresenter: EditCommsPresenterProtocol!
    var comm: Article!

    var oldTitle: String = ""
    var oldDescription: String = ""
    var oldHighlighted: Bool = false;
    var oldCategory: Category!
    //var oldImage: UIImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEditableFields()
        
       self.navigationController!.navigationBar.prefersLargeTitles = false
        
        editCommsTitle.text = comm.title
        
        oldTitle = comm.title
        oldDescription = comm.content
        oldHighlighted = comm.highlighted
        oldCategory = comm.category
        //oldImage = comm.image
        
        self.navigationItem.title = "Edit"
        
        self.editCommsCategory?.layer.cornerRadius = editCommsCategory.frame.size.height/5.0
        self.editCommsCategory?.layer.masksToBounds = true
        self.previewButton?.layer.cornerRadius = previewButton.frame.size.height/5.0
        self.previewButton?.layer.masksToBounds = true
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEdittedCommTapped))

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editCommsImageTapped(_:)))
        editOverlayButton.isUserInteractionEnabled = true
        editOverlayButton.addGestureRecognizer(tapGestureRecognizer)
        
        editCommsCategory.setTitle(oldCategory.category_name, for: .normal)
        let result = oldHighlighted ? 0 : 1
        editCommsHighlighted.selectedSegmentIndex = result

    }
    
    @objc func saveEdittedCommTapped() {
        if(oldTitle == editCommsTitle.text &&
            oldDescription == editCommsDescription.text &&
            oldHighlighted == editCommsHighlighted.isSelected &&
            oldCategory.category_name == editCommsCategory.titleLabel!.text
            //oldImage == editCommsImage.
            ){
            let alert = UIAlertController(title: "Error", message: "No changes made! Please ensure that you make changes before you click save!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Remove alert"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            editCommsPresenter.didTapSave(for: comm)
        }
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        editCommsDescription.resignFirstResponder()
        editCommsTitle.resignFirstResponder()
    }
    
    func setUpEditableFields() {
        editCommsPresenter.loadComm()
        editCommsCategory.titleLabel?.text = comm.category.category_name
        guard let url = URL(string: comm.image) else {
            print("bad url")
            return
        }
        editCommsImage.kf.setImage(with: url)
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
