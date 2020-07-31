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
    @IBOutlet weak var editCommsDescription: UITextView!
    @IBOutlet weak var editCommsHighlighted: UISegmentedControl!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var editOverlayButton: UIButton!
    
    var selectedCategory: Category!
    var editCommsPresenter: EditCommsPresenterProtocol!
    var comm: Article!

    var oldTitle: String = ""
    var oldDescription: String = ""
    var oldHighlighted: Bool = false;
    var oldCategory: Category!
    var user: NewUser!
    
    //var oldImage: UIImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEditableFields()
        
       self.navigationController!.navigationBar.prefersLargeTitles = false
        
//        oldTitle = comm.title!
//        oldDescription = comm.content!
//        oldHighlighted = comm.highlighted
//        oldCategory = comm.articleCategories[0].category
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
        
//        let result = oldHighlighted ? 0 : 1
//        editCommsHighlighted.selectedSegmentIndex = result

    }
    
    @objc func saveEdittedCommTapped() {
        if(oldTitle == editCommsTitle.text &&
            oldDescription == editCommsDescription.text &&
            oldHighlighted == editCommsHighlighted.isSelected &&
            oldCategory.categoryName == editCommsCategory.titleLabel!.text
            //oldImage == editCommsImage.
            ) {
            let alert = UIAlertController(title: "Error", message: "No changes made! Please ensure that you make changes before you click save!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Remove alert"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            editCommsPresenter.didTapSave(for: EditArticle(articleID: comm.articleID, title: editCommsTitle.text!, content: editCommsDescription.text!, articleCategories: [NewArticleCategory(category: NewCategory(categoryID: comm.articleCategories[0].category.categoryID, categoryName: (editCommsCategory.titleLabel?.text!)!))], dateCreated: "\(Date())", dateLastUpdated: "\(Date())", user: self.user, highlighted: editCommsHighlighted.selectedSegmentIndex == 0, picture: ""))
        }
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        editCommsDescription.resignFirstResponder()
        editCommsTitle.resignFirstResponder()
    }
    
    func setUpEditableFields() {
        editCommsPresenter.loadComm()
        editCommsTitle.layer.borderWidth = 1
        editCommsTitle.layer.borderColor =  UIColor.lightGray.cgColor
        editCommsTitle.layer.cornerRadius = 5
        editCommsDescription.layer.borderWidth = 1
        editCommsDescription.layer.borderColor =  UIColor.lightGray.cgColor
        editCommsDescription.layer.cornerRadius = 5
    }
    
    @IBAction func editCommsImageTapped(_ sender: Any) {
        showImagePickerControllerActionSheet()
    }

    @IBAction func selectCategoryTapped(_ sender: Any) {
        editCommsPresenter.didTapSelectCategory()
    } 
    
}

extension EditCommsViewController: EditCommsPresenterView {
    func setCategory(with category: Category) {
        selectedCategory = category
        editCommsCategory.titleLabel?.text = selectedCategory.categoryName
        
    }
    
    func setCommsData(with article: Article) {
        comm = article
        DispatchQueue.main.async {
            self.editCommsTitle.text = self.comm.title
            self.editCommsCategory.setTitle(self.comm.articleCategories[0].category.categoryName, for: .normal)
            if let imageUrl = self.comm.picture {
                if let url = URL(string: imageUrl) {
                    self.editCommsImage.kf.setImage(with: url)
                }
                else {
                    self.editCommsImage.image = #imageLiteral(resourceName: "banner")
                }
            }
            else {
                self.editCommsImage.image = #imageLiteral(resourceName: "banner")
            }
            self.editCommsDescription.text = self.comm.content
            self.editCommsHighlighted.selectedSegmentIndex = self.comm.highlighted ? 0 : 1
            print("segmentcontrol", self.editCommsHighlighted.selectedSegmentIndex)
        }
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
