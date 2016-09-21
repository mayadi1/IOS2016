//
//  InfoTableViewController.swift
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
    
    class InfoTableViewController: UITableViewController {
        @IBOutlet weak var nnn: UILabel!
        @IBOutlet weak var age: UILabel!
        @IBOutlet weak var diss: UISlider!
        @IBOutlet weak var agleS: UISlider!
        
        @IBOutlet weak var ageValue: UISlider!
        override func viewDidLoad() {
            super.viewDidLoad()
            self.hideKeyboardWhenTappedAround()
            
            
            
            
            // Do any additional setup after loading the view.
        }
        
        
        @IBAction func slider(_ sender: AnyObject) {
            
            let num = Int(self.ageValue.value)
            
            
            self.age.text = "\(num)"
        }
        
        
        @IBAction func dis(_ sender: AnyObject) {
            let num2 = Int(self.diss.value)
            
            
            self.nnn.text = "\(num2)" + " Miles"
            
        }
        
        
        
        
        
        
        
        
}//End of the ProfileInfo VC

