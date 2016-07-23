//
//  ProfileViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        
      
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
