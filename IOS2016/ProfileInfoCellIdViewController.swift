//
//  ProfileInfoCellIdViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import SideMenu
import FirebaseDatabase

class ProfileTVC: UITableViewController {

    var userInfo = [UsersInfo]()
    
    @IBOutlet weak var naviItem: UINavigationItem!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var value2: UILabel!
    @IBOutlet weak var bio: UITextView!
    
    @IBOutlet weak var value3: UILabel!
    @IBOutlet weak var value1: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var job: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.naviItem.title = userInfo[0].name
        self.age.text = userInfo[0].age
        self.value2.text = userInfo[0].value2
        self.bio.text = userInfo[0].bio
        self.value3.text = userInfo[0].value3
        self.value1.text = userInfo[0].value1
        self.height.text = userInfo[0].height
        self.school.text = userInfo[0].school
        self.job.text = userInfo[0].job

    }

   

    
    
    
    
    
    
    
    
    
}//End of the ProfileInfo VC
