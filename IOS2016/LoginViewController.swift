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
import FBSDKCoreKit
import SideMenu
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.activityIndicator.hidden = true
        
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUP: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.hidden = true
        
        self.loginButton.backgroundColor = UIColor(red:0.09, green:0.13, blue:0.34, alpha:1.0)
        
        self.signUP.backgroundColor = UIColor(red:0.09, green:0.13, blue:0.34, alpha:1.0)
        
        
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
    
    //Hide Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        self.activityIndicator.hidden = false
        
        
        self.activityIndicator.startAnimating()
        FIRAuth.auth()?.signInWithEmail(userNameField.text!, password: passwordField.text!) { (user, error) in
            
            if error == nil {
                
                
                let myValue:NSString = self.userNameField.text!
                
                let loginStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let MapViewController: UIViewController = loginStoryBoard.instantiateViewControllerWithIdentifier("MainVC")
                
                self.presentViewController(MapViewController, animated: false, completion: nil)
                
                
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


