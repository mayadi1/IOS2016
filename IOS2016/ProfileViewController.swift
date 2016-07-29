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
import FBSDKCoreKit

class ProfileViewController: UITableViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameAge: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var employer: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var PoliticalIdeology: UILabel!
    
    @IBOutlet weak var partyAffiliation: UILabel!

    @IBOutlet weak var religion: UILabel!
    
    @IBOutlet weak var bio: UITextView!

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        if let imgData = defaults.objectForKey("image") as? NSData
        {
            if let image = UIImage(data: imgData)
            {
                //set image in UIImageView imgSignature
                self.profileImage.image = image
                //remove cache after fetching image data
            }
        }
        
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            
            
            let value = snapshot.value
            
            let tempProfileInfoArray = value as! NSDictionary
            
            self.partyAffiliation.text = tempProfileInfoArray["value1"] as? String
            self.PoliticalIdeology.text = tempProfileInfoArray["value2"] as? String
            self.religion.text = tempProfileInfoArray["value3"] as? String
            
            
        })
        
    }
    
    override func viewDidLoad() {
        
      
        super.viewDidLoad()

        let user = FIRAuth.auth()?.currentUser

        self.nameAge.text = user?.displayName
        
      
        
        
        
      
    }
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        
        // Facebook log out by setting access token to nil, then sending back to the initial viewcontroller.
        
      FBSDKAccessToken.setCurrentAccessToken(nil)
        
        try! FIRAuth.auth()!.signOut()
        print("signed out")
        
        self.view.window!.rootViewController?.dismissViewControllerAnimated(true, completion: nil)


        
    }
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    
}//End of the PVC class

