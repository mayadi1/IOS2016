//
//  newMatchesUserInfoTableViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 9/25/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func likeButtonPressed(_ sender: AnyObject) {
    }
    
    @IBAction func dislikeButtonPressed(_ sender: AnyObject) {
    }
}
