//
//  FBValuesViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/29/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class FBValuesViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView: UIPickerView!
    var job = "none"
    var school = "none"
    var bio = "none"
    var userType = "none"
    var height = "none"
    
    var data = ["", "Absolutist", "Anarchist", "Capitalist", "Communist", "Conservative", "Environmentalist", "Liberal", "Socialist", "Other"]
    
    var data2 = ["", "Democrat", "Republican", "Independant", "Libertarian", "Green", "Constitution", "Unaffiliated"]
    
    var data3 = ["", "Agnostic", "Atheist", "Buddhist", "Christian", "Christian/Baptist", "Christian/Catholic", "Christian/Mormon", "Christian/Protestant", "Christian/Unitarian", "Christian/Other", "Christian/Unitarian", "Hindu", "Jain", "Jewish", "Jewish/Conservative", "Jewish/Modern Orthodox", "Jewish/Orthodox", "Jewish/Reform", "Jewish/Other", "Muslim", "Muslim/Sunni", "Muslim/Shi`ite", "Muslim/Sufi", "Muslim/Other", "Sikh", "Taoist", "Other"]
    
    var temp1: String?
    var temp2: String?
    var temp3: String?
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
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
    @IBAction func goBuckButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        if job == "none"{
            
            let jobAlert = UIAlertController(title: "What's your professional headline?", message: nil, preferredStyle: .alert)
            jobAlert.addTextField(configurationHandler: { (UITextField) in
                
                
            })
            let jobSave  = UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
                self.job = (jobAlert.textFields?.first?.text)!
            })
            jobAlert.addAction(jobSave)
            present(jobAlert, animated: true, completion: nil)
            self.view.endEditing(true)
            sender.setTitle("Next", for: .normal)
        }
        
        if school == "none"{
            let jobAlert = UIAlertController(title: "What's your recent School?", message: nil, preferredStyle: .alert)
            jobAlert.addTextField(configurationHandler: { (UITextField) in
                
                
            })
            let jobSave  = UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
                self.school = (jobAlert.textFields?.first?.text)!
            })
            jobAlert.addAction(jobSave)
            present(jobAlert, animated: true, completion: nil)
            self.view.endEditing(true)
            sender.setTitle("Next", for: .normal)
        }
        if userType == "none"{
            
            let jobAlert = UIAlertController(title: "Are you male or female?", message: nil, preferredStyle: .alert)
            jobAlert.addTextField(configurationHandler: { (UITextField) in
                
            })
            let jobSave  = UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
                self.userType = (jobAlert.textFields?.first?.text)!
            })
            jobAlert.addAction(jobSave)
            present(jobAlert, animated: true, completion: nil)
            self.view.endEditing(true)
            sender.setTitle("Next", for: .normal)
        }
        
        if height == "none"{
            
            let jobAlert = UIAlertController(title: "What's your height?", message: nil, preferredStyle: .alert)
            jobAlert.addTextField(configurationHandler: { (UITextField) in
                
            })
            let jobSave  = UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
                self.height = (jobAlert.textFields?.first?.text)!
            })
            jobAlert.addAction(jobSave)
            present(jobAlert, animated: true, completion: nil)
            self.view.endEditing(true)
            sender.setTitle("Next", for: .normal)
        }
        
        
        if bio == "none"{
            let jobAlert = UIAlertController(title: "What's your bio?", message: nil, preferredStyle: .alert)
            jobAlert.addTextField(configurationHandler: { (UITextField) in
                
                
            })
            let jobSave  = UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
                self.bio = (jobAlert.textFields?.first?.text)!
                sender.setTitle("Done", for: .normal)
            })
            jobAlert.addAction(jobSave)
            present(jobAlert, animated: true, completion: nil)
            self.view.endEditing(true)
            
            
        }
        else{
        
        let user = FIRAuth.auth()?.currentUser
            
        
        rootRef.child("users").child("\(user!.uid)").child("username").setValue(user?.displayName)
        rootRef.child("users").child("\(user!.uid)").child("useruid").setValue("\(user!.uid)")
        rootRef.child("users").child("\(user!.uid)").child("useremail").setValue(user?.email)
        
        rootRef.child("users").child("\(user!.uid)").child("follow").setValue("0")
        rootRef.child("users").child("\(user!.uid)").child("valid").setValue("yes")
        
        
        rootRef.child("users").child("\(user!.uid)").child("value1").setValue(self.temp1)
        rootRef.child("users").child("\(user!.uid)").child("value2").setValue(self.temp2)
        rootRef.child("users").child("\(user!.uid)").child("value3").setValue(self.temp3)
        rootRef.child("users").child("\(user!.uid)").child("job").setValue(self.job)
        rootRef.child("users").child("\(user!.uid)").child("school").setValue(self.school)
        rootRef.child("users").child("\(user!.uid)").child("bio").setValue(self.bio)
        rootRef.child("users").child("\(user!.uid)").child("userType").setValue(self.userType)
        rootRef.child("users").child("\(user!.uid)").child("height").setValue(self.height)


            
        rootRef.child("users").child("\(user!.uid)").child("userProfilePic").setValue(user?.photoURL?.relativeString)
        
        
        let loginStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // Uncomment this when we get feed done and add HomeView as the storyboard id.
        
        let MapViewController: UIViewController = loginStoryBoard.instantiateViewController(withIdentifier: "MainVC")
        
        self.present(MapViewController, animated: false, completion: nil)
        
        }
        
    }
    
    
}//End of FBVC Class
