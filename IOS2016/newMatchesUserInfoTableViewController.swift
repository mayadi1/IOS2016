//
//  newMatchesUserInfoTableViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 9/25/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase

class newMatchesUserInfoTableViewController: UITableViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var value1: UILabel!
    @IBOutlet weak var value2: UILabel!
    @IBOutlet weak var value3: UILabel!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var uid: UILabel!
    
    let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func likeButtonPressed(_ sender: AnyObject) {
        let autoId = ref.childByAutoId()
        let timeStamp = Int(NSDate().timeIntervalSince1970)
        
        let autoId2 = ref.childByAutoId()
        let value2 =  ["messages": "This is the very beginning of your direct message. Direct messages are private between the two of you", "fromId": (FIRAuth.auth()?.currentUser?.uid)! as String, "toId": self.uid.text! as String, "timeStamp": String(timeStamp)]
        
        ref.child("userMessages").child(autoId2.key).childByAutoId().setValue(value2)
        let value = ["userMessages": autoId2.key, "fromId": (FIRAuth.auth()?.currentUser?.uid)! as String, "toId": self.uid.text! as String, "timeStamp": String(timeStamp)]
        ref.child("messages").child(autoId.key).setValue(value)
        ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("chatPointerTo").childByAutoId().setValue(autoId.key)
        ref.child("users").child(self.uid.text!).child("chatPointerTo").childByAutoId().setValue(autoId.key)

        //TO DO: I need a protocol to hide this view from superview.
    }
    
    @IBAction func dislikeButtonPressed(_ sender: AnyObject) {
    }
}
