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
    
    let rootRef = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser
    
    
  
    
    override func viewDidLoad() {
        
      
        super.viewDidLoad()

        
        let ref = rootRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        }


}
