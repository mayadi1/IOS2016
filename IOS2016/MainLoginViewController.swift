//
//  MainLoginViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/24/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//
import UIKit
import Firebase
import FirebaseStorage
import FBSDKCoreKit
import SideMenu
import FirebaseDatabase
import FBSDKLoginKit
class MainLoginViewController: UIViewController,FBSDKLoginButtonDelegate {
    var loginButton: FBSDKLoginButton = FBSDKLoginButton()
    
    let usersRef = FIRDatabase.database().reference().child("users")
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.loginButton.center = self.view.center
        self.loginButton.clipsToBounds = true
        self.loginButton.delegate = self
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        customizeButton(self.facebookLoginButton)
        
        
        
        //        self.view!.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        
        // Code to deal with users who hit cancel on the facebook login access.
        if (error != nil)
        {
            // If error occurs, login button appears
            self.facebookLoginButton.isHidden = false
        }
        else if(result.isCancelled) {
            print("user did cancl")
            // handle the cancel event, show the login button
            self.facebookLoginButton.isHidden = false
            
        } else {  // User hits OK to grant rights to use Facebook Login.
            print("user logged in")
            
            
            
            // Since Firebase cannot see users logged in even with facebook set up correctly, we have to add this code. Located in guides, auth, facebook, step 4.
            
            // This is getting an access token for the signed-in user and exchanging it for a Firebase credential:
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            
            // Step 5 authenticate with Firebase using the Firebase credential
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                print("user logged into firebase")
                
                // When user signed in with Facebook, send to address view controller.
                let rootRef = FIRDatabase.database().reference()
                
                
                
                let condition = self.usersRef.child("\(user!.uid)")
                
                condition.observe(.value, with:  { (snapshot) in
                    
                    
                    if snapshot.exists() {
                        
                        
                        
                        let loginStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        // Uncomment this when we get feed done and add HomeView as the storyboard id.
                        
                        let MapViewController: UIViewController = loginStoryBoard.instantiateViewController(withIdentifier: "MainVC")
                        
                        self.present(MapViewController, animated: false, completion: nil)
                        
                        
                        
                    } else {
                        
                        
                        let loginStoryBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                        // Uncomment this when we get feed done and add HomeView as the storyboard id.
                        
                        let MapViewController: UIViewController = loginStoryBoard.instantiateViewController(withIdentifier: "FbValuesAdd")
                        
                        self.present(MapViewController, animated: false, completion: nil)
                        
                    }
                    
                    
                })
                
                
                
            }
            
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("user logged out")
    }
    
    // Customizing Facebook Login Button
    func customizeButton(_ button: UIButton!) {
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
        
    }
    
    
}
