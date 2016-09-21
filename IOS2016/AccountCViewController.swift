//
//  ProfileViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//
import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var selectedPhoto: UIImage!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNamerTextField: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.selectPhoto(_:)))
        tap.numberOfTapsRequired = 1
        profileImage.addGestureRecognizer(tap)
        
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 3
        profileImage.clipsToBounds = true
        
    }
    
    
    
    
    
    func selectPhoto(_ tap: UITapGestureRecognizer) {
        
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        
        let photoOptionAlertController = UIAlertController(title: "SourceType?", message: nil, preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Take a Camera Shot", style: .default, handler: { (UIAlertAction) in
            
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
            
            
        })
        
        let photoLibraryAction = UIAlertAction(title: "Choose from Photo Library", style: .default, handler: { (UIAlertAction) in
            
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
            
            // ..
        }
        
        photoOptionAlertController.addAction(cameraAction)
        photoOptionAlertController.addAction(photoLibraryAction)
        photoOptionAlertController.addAction(cancelAction)
        
        self.present(photoOptionAlertController, animated: true, completion: nil)
    }

 
    
    
    @IBAction func CreateAccount(_ sender: AnyObject) {
                
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.selectedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        self.profileImage.image = selectedPhoto
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ValuesViewController
        
        dvc.passedName = self.userNamerTextField.text
        dvc.passedEmail = self.emailText.text
        dvc.passedPassword = self.passwordText.text
        dvc.image = self.selectedPhoto
        
    }
    @IBAction func gobackButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
}//End of the class
