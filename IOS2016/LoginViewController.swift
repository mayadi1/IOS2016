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
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.activityIndicator.hidden = true
        
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUP: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.activityIndicator.hidden = true
        
     
   
        
        
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
    
    //Hide Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    

    
}//End of the LoginVC CLass


