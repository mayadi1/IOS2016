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
    
    
    @IBAction func LogIn(_ sender: AnyObject) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
                
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    
                }
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion:nil)
                
                
                
                return
            }else{
              
                
                let loginStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                // Uncomment this when we get feed done and add HomeView as the storyboard id.
                
                let MapViewController: UIViewController = loginStoryBoard.instantiateViewController(withIdentifier: "MainVC")
                
                self.present(MapViewController, animated: false, completion: nil)

              
                
                
            }
            
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}//End of the LoginVC CLass


