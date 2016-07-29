//
//  LoginViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth


class LoginViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
    }
    
    
    @IBAction func LogIn(sender: AnyObject) {
        
        FIRAuth.auth()?.signInWithEmail(emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
                
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
                
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                    
                }
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true, completion:nil)
                
                
                
                return
            }else{
              
                
                let loginStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                // Uncomment this when we get feed done and add HomeView as the storyboard id.
                
                let MapViewController: UIViewController = loginStoryBoard.instantiateViewControllerWithIdentifier("MainVC")
                
                self.presentViewController(MapViewController, animated: false, completion: nil)

              
                
                
            }
            
            
        }
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}//End of the LoginVC CLass


