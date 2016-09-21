//
//  ValuesViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class ValuesViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var activityAnimation: UIActivityIndicatorView!
    var temp1: String?
    var temp2: String?
    var temp3: String?
    @IBOutlet weak var doneButton: UIButton!
    
    var passedName: String?
    var passedEmail: String?
    var passedPassword: String?
    var image: UIImage?
    
    let rootRef = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser

    
    var data = ["", "Absolutist", "Anarchist", "Capitalist", "Communist", "Conservative", "Environmentalist", "Liberal", "Socialist", "Other"]
    
    var data2 = ["", "Democrat", "Republican", "Independant", "Libertarian", "Green", "Constitution", "Unaffiliated"]
    
    var data3 = ["", "Agnostic", "Atheist", "Buddhist", "Christian", "Christian/Baptist", "Christian/Catholic", "Christian/Mormon", "Christian/Protestant", "Christian/Unitarian", "Christian/Other", "Christian/Unitarian", "Hindu", "Jain", "Jewish", "Jewish/Conservative", "Jewish/Modern Orthodox", "Jewish/Orthodox", "Jewish/Reform", "Jewish/Other", "Muslim", "Muslim/Sunni", "Muslim/Shi`ite", "Muslim/Sufi", "Muslim/Other", "Sikh", "Taoist", "Other"]
    
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityAnimation.isHidden = true
        self.hideKeyboardWhenTappedAround()

        
    }

    //Hide Status Bar
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return self.data.count
        } else if pickerView.tag == 2 {
            return self.data2.count
        } else if pickerView.tag == 3 {
            return  self.data3.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return data[row]
        } else if pickerView.tag == 2 {
            return data2[row]
        } else if pickerView.tag == 3 {
            return data3[row]
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView.tag == 1{
            self.temp1  = self.data[row]
            
        }
        if pickerView.tag == 2{
            self.temp2  = self.data2[row]
            
            
        }
        if pickerView.tag == 3{
            self.temp3  = self.data3[row]
            
        }
        
    }
    func ResizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        self.doneButton.isEnabled = false
        
        self.activityAnimation.isHidden = false
        self.activityAnimation.startAnimating()
        var data = Data()
        
        let newImage = self.ResizeImage(self.image!,targetSize: CGSize(width: 382, height: 725))
        data = UIImageJPEGRepresentation(newImage, 0.1)!
        
        
        
        FIRAuth.auth()?.createUser(withEmail: self.passedEmail!, password: self.passedPassword!, completion: { (user, error) in
            if let error = error {
                
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    
                }
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion:nil)
                
                
                
                
                
                
                return
            }else{
                let rootRef = FIRDatabase.database().reference()
                
                rootRef.child("users").child("\(user!.uid)").child("username").setValue(self.passedName)
                rootRef.child("users").child("\(user!.uid)").child("useruid").setValue("\(user!.uid)")
                rootRef.child("users").child("\(user!.uid)").child("useremail").setValue(self.passedEmail)
                
                rootRef.child("users").child("\(user!.uid)").child("follow").setValue("0")
                rootRef.child("users").child("\(user!.uid)").child("valid").setValue("yes")
                
                
                rootRef.child("users").child("\(user!.uid)").child("value1").setValue(self.temp1)
                rootRef.child("users").child("\(user!.uid)").child("value2").setValue(self.temp2)
                rootRef.child("users").child("\(user!.uid)").child("value3").setValue(self.temp3)

                
                
                let changeRequest = user?.profileChangeRequest()
                changeRequest?.displayName = self.passedName
                changeRequest?.commitChanges(completion: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                        
                        
                        
                        
                        return
                    }
                    
                    
                    
                    
                    
                })
                let filePath = "profileImage/\(user!.uid)"
                let metadata =  FIRStorageMetadata()
                metadata.contentType = "image/jpeg"
                
                self.storageRef.child(filePath).put(data, metadata: metadata, completion: { (metadata, error) in
                    if let error = error{
                        print("\(error)")
                        
                        
                        
                        return
                    }
                    self.fileUrl = metadata?.downloadURLs![0].absoluteString
                    rootRef.child("users").child("\(user!.uid)").child("userProfilePic").setValue(self.fileUrl)
                    let changeREquestPhoto = user!.profileChangeRequest()
                    changeREquestPhoto.photoURL = URL(string: self.fileUrl)
                    changeREquestPhoto.commitChanges(completion: { (error) in
                        if let error = error{
                            print(error.localizedDescription)
                            return
                        }else{
                            print("Profile Updated")
                            
                            let loginStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            
                            let MapViewController: UIViewController = loginStoryBoard.instantiateViewController(withIdentifier: "MainVC")
                            
                            self.present(MapViewController, animated: false, completion: nil)
                            
                        }
                    })
                    
                })
                
                
                
            }
            
        })

        FIRAuth.auth()?.signIn(withEmail: self.passedEmail!, password: self.passedPassword!) { (user, error) in
         
           

    
        }
        
    }

    var storageRef: FIRStorageReference{
        return FIRStorage.storage().reference()
        
    }
    
    var fileUrl: String!

    @IBAction func goBuckButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}//End of VC class
