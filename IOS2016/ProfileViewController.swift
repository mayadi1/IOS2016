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
    }
    
    override func viewDidLoad() {
        
      
        super.viewDidLoad()

        let user = FIRAuth.auth()?.currentUser

        
      
        
        
        
        let ref = FIRDatabase.database().reference()
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            
            let snap = snapshot.value
            
            let name = snap!["username"] as! String
            self.nameAge.text = name
            
            let value1 = snap!["value1"] as! String
            self.PoliticalIdeology.text = value1

            let value2 = snap!["value2"] as! String
            self.partyAffiliation.text = value2

            let value3 = snap!["value3"] as! String
            self.religion.text = value3

            
//            let filePath = snap!["userProfilePic"] as! String
//       
//          let url = NSURL(string: filePath)
//            if let data = NSData(contentsOfURL: url!){
//                self.profileImage!.image = UIImage.init(data: data)}
           
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        
        // Facebook log out by setting access token to nil, then sending back to the initial viewcontroller.
        
//        FBSDKAccessToken.setCurrentAccessToken(nil)
        
        try! FIRAuth.auth()!.signOut()
        print("signed out")
        
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let ViewController: UIViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("LoginView")
        
        self.presentViewController(ViewController, animated: true, completion: nil)
        

        
    }
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    
}//End of the PVC class

