//
//  AddCommsViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

    
class AddCommsViewController: UIViewController, Storyboarded {

   
    @IBOutlet weak var commImage: UIImageView!
    @IBOutlet weak var commsTitle: UITextField!
    @IBOutlet weak var commsContent: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var isHighlighted: UISegmentedControl!
    @IBOutlet weak var saveButtonNew: UIButton!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    let customActionSheet = CustomActionSheet()
    
    var addCommsPresenter: AddCommsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.navigationItem.title = "Create New Comms"
        
        self.categoryButton?.layer.cornerRadius = categoryButton.frame.size.height/5.0
        self.categoryButton?.layer.masksToBounds = true
        self.saveButtonNew?.layer.cornerRadius = saveButtonNew.frame.size.height/5.0
        self.saveButtonNew?.layer.masksToBounds = true
        self.previewButton?.layer.cornerRadius = previewButton.frame.size.height/5.0
        self.previewButton?.layer.masksToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapUploadImage(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)

        let savePostButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(postButtonTapped(_:)))

        navigationItem.rightBarButtonItems = [savePostButton]
        
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    
   
    @objc func postButtonTapped(_ sender: Any) {
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
        
        addCommsPresenter.didTapPost()
        
    }
    
    @IBAction func onTapUploadImage(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        customActionSheet.showAlert(title: "What woud you like to do?",
                                          message: "Use image from",
                                          optionOne: "Library",
                                          optionTwo: "Camera",
                                          viewController: self,completion: { (result) -> Void in
            if result == "Camera" {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .camera
            } else {
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .photoLibrary
            }
            self.present(self.imagePicker, animated: true, completion: nil)
        })
    }
    
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
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

extension AddCommsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
    //            print(pickedImage)
    //            var test = convertImageToBase64String(img: pickedImage)
    //            print(test)
                commImage.contentMode = .scaleAspectFill
                commImage.image = pickedImage
                let imageData = pickedImage.jpegData(compressionQuality: 1)
                print(imageData)

            }
         
            dismiss(animated: true, completion: nil)
        }
}

extension AddCommsViewController: AddCommsPresenterView {
    func errorOccured(message: String) {
        print(message)
    }
}

