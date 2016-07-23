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

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameAge: UITextField!
    @IBOutlet weak var jobTitle: UITextField!
    @IBOutlet weak var employer: UITextField!
    @IBOutlet weak var school: UITextField!
    @IBOutlet weak var PoliticalIdeology: UITextField!
    
    @IBOutlet weak var partyAffiliation: UITextField!

    @IBOutlet weak var religion: UITextField!
    
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
    
    
    
}//End of the PVC class

