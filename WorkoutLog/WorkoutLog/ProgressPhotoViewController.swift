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
    @IBOutlet weak var savedLabel: UILabel!
    
    @IBAction func tapToPickImage(_ sender: Any) {
        getImage()
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if progressPhotoImageView.image == UIImage(named: "TapToAddImage") {
            let photo = progressPhotoImageView.image ?? UIImage()
            guard let weight = weightTextField.text, !weight.isEmpty else { return }
            guard let doubleWeight = Double(weight) else { return }
            ProgressController.shared.createProgressWithPhotoAndWeight(photo: photo, weight: doubleWeight)
        }
        
        progressPhotoImageView.image = UIImage(named: "TapToAddImage")
        weightTextField.text = ""
        
        savedLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(endTimer), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        savedLabel.isHidden = true
        timer.invalidate()
    }
    
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        savedLabel.isHidden = true
        savedLabel.textColor = UIColor.exerciseOrange
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
