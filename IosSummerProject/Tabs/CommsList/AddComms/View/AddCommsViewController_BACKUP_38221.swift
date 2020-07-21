//
//  AddCommsViewController.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class AddCommsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var commsTitle: UITextField!
    @IBOutlet weak var commsContent: UITextField!
=======
class AddCommsViewController: UIViewController, Storyboarded, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var commImage: UIImageView!
    let imagePicker = UIImagePickerController()
>>>>>>> bbf204fd748e23a7e40bc627e0377e6db9f4a95a
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
<<<<<<< HEAD
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
    
=======
    @IBAction func onTapUploadImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            print(pickedImage)
//            var test = convertImageToBase64String(img: pickedImage)
//            print(test)
            commImage.contentMode = .scaleAspectFit
            commImage.image = pickedImage
            let imageData = pickedImage.jpegData(compressionQuality: 1)
            print(imageData)

        }
     
        dismiss(animated: true, completion: nil)
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }

>>>>>>> bbf204fd748e23a7e40bc627e0377e6db9f4a95a
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
