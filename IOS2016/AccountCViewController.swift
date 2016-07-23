//
//  AccountCViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class AccountCViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let imagePicker = UIImagePickerController()
    var selectedPhoto: UIImage?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var genderSeg: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let pushedTap = UITapGestureRecognizer(target: self, action: #selector(AccountCViewController.selectPhoto(_:)))
        pushedTap.numberOfTapsRequired = 1
        profileImage.addGestureRecognizer(pushedTap)

        
        

        // Do any additional setup after loading the view.
    }

    //Hide Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
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
    
    var storageRef: FIRStorageReference{
        return FIRStorage.storage().reference()
        
    }
    
    var fileUrl: String!
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.selectedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        self.profileImage.image = selectedPhoto
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}//End of AVC class





