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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.selectPhoto(_:)))
        tap.numberOfTapsRequired = 1
        profileImage.addGestureRecognizer(tap)
        
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 3
        profileImage.clipsToBounds = true
        
    }
    
    
    
    
    
    func selectPhoto(tap: UITapGestureRecognizer) {
        
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        
        let photoOptionAlertController = UIAlertController(title: "SourceType?", message: nil, preferredStyle: .Alert)
        
        let cameraAction = UIAlertAction(title: "Take a Camera Shot", style: .Default, handler: { (UIAlertAction) in
            
            self.imagePicker.sourceType = .Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
            
        })
        
        let photoLibraryAction = UIAlertAction(title: "Choose from Photo Library", style: .Default, handler: { (UIAlertAction) in
            
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (UIAlertAction) in
            
            // ..
        }
        
        photoOptionAlertController.addAction(cameraAction)
        photoOptionAlertController.addAction(photoLibraryAction)
        photoOptionAlertController.addAction(cancelAction)
        
        self.presentViewController(photoOptionAlertController, animated: true, completion: nil)
    }

 
    
    
    @IBAction func CreateAccount(sender: AnyObject) {
                
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.selectedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        self.profileImage.image = selectedPhoto
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
       
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! ValuesViewController
        
        dvc.passedName = self.userNamerTextField.text
        dvc.passedEmail = self.emailText.text
        dvc.passedPassword = self.passwordText.text
        dvc.image = self.selectedPhoto
        
    }
    
}//End of the class