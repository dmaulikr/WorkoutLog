//
//  ProgressPhotoViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/22/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class ProgressPhotoViewController: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var progressPhotoImageView: UIImageView!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBAction func tapToPickImage(_ sender: Any) {
        getImage()
    }

//    @IBAction func saveButtonTapped(_ sender: Any) {
//        if (progressPhotoImageView.image != nil) && progressPhotoImageView.image != UIImage(named: "TapToAddImage") {
//            if let weight = weightTextField.text {
//                guard let weightDouble = Double(weight) else { return }
//                ProgressController.shared.createProgressWithPhotoAndWeight(photo: progressPhotoImageView.image, weight: weightDouble)
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
    }
    
    func getImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo", message: "Choose Source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                print("Camera not available")
                let alertController = UIAlertController(title: "Camera not available", message: "You have not given permission to use the camera or there is no available camera to use.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        progressPhotoImageView.contentMode = .scaleAspectFit
        self.progressPhotoImageView.image = originalImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


}


//MARK: - Keyboard Extension
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
