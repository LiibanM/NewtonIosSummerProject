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
    
    // This should only be stored on your presenter, not your vc and using your presenters view delegate you can pass info as needed to display
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
        
        // FROM HERE
        // This should be returned to you via your presenter view
        // You should have a function that returns the object to your vc so it can update as needed
        editCommsTitle.text = comm.title
        
        oldTitle = comm.title
        oldDescription = comm.content
        oldHighlighted = comm.highlighted
        oldCategory = comm.category
        //oldImage = comm.image
        // TO HERE
        
        self.navigationItem.title = "Edit"
        
        // There should not be ?'s here because your outlets use a ! in their denotion meaning it will never be nil
        // Remove them
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
        // This code should be in your presenter
        if(oldTitle == editCommsTitle.text &&
            oldDescription == editCommsDescription.text &&
            oldHighlighted == editCommsHighlighted.isSelected &&
            oldCategory.category_name == editCommsCategory.titleLabel!.text
            //oldImage == editCommsImage.
            ) {
            
            // This should be displayed via your errorOcurred function with the message and title coming from the presenter
            let alert = UIAlertController(title: "Error", message: "No changes made! Please ensure that you make changes before you click save!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Remove alert"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // This function should just have this one line in
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
        
        // Provide a default image if URL is bad
        guard let url = URL(string: comm.image) else {
            print("bad url")
            return
        }
        
        editCommsImage.kf.setImage(with: url)
        editCommsTitle.layer.borderWidth = 1
        editCommsTitle.layer.borderColor =  UIColor.lightGray.cgColor
        editCommsTitle.layer.cornerRadius = 5
        editCommsDescription.layer.borderWidth = 1
        editCommsDescription.layer.borderColor =  UIColor.lightGray.cgColor
        editCommsDescription.layer.cornerRadius = 5
//        editCommsDescription.layer.backgroundColor = UIColor.lightGray.cgColor
        editCommsDescription.text = comm.content
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
        editCommsCategory.titleLabel?.text = selectedCategory.category_name
    }
    
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
        // Spacing between alert =  UIAler (2 spaces on right of =)
        // Should really have a AlertService that you can call instead of creating these everywhere
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
            // Get the URL of the image and store that
            // In your presenter you can then go and grab the ImageContent if you need it
            // Use the InfoKey.imageURL
            editCommsImage.image = editedImage
            let imageData = editedImage.pngData()
            print(imageData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters))
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            editCommsImage.image = originalImage
        }

        dismiss(animated: true, completion: nil)
    }
}
