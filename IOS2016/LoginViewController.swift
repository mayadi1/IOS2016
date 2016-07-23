//
//  LoginViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    
    //Hide Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }



    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        
        
        FIRAuth.auth()?.signInWithEmail(userNameField.text!, password: passwordField.text!) { (user, error) in
            
            if error == nil {
                print("User Logged In")
                
                self.performSegueWithIdentifier("loginToMap", sender: self)
                
                let myValue:NSString = self.userNameField.text!
           
            }
            else {
                print("Invalid Login")
                print(error?.code)
                
                let alertController = UIAlertController(title: nil, message: "\(error!.localizedDescription)", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "Try Again", style: .Default) { (action) in
                    // ...
                }
                alertController.addAction(OKAction)
                //
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
            }
            
        }

    }

}//End of the LoginVC CLass


