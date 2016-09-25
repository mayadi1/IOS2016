//
//  ChatViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 9/25/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase
class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
//Update chat 
    @IBOutlet weak var text: UITextField!
    var passedMessages = [String]()
    var passedChatChildKey: String?
    var passedCurrentUserUid: String?
    let ref = FIRDatabase.database().reference()
    let timeStamp = Int(NSDate().timeIntervalSince1970)

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        cell.textLabel?.text = passedMessages[indexPath.row]
        return cell
    }
    @IBAction func sendButtonPressed(_ sender: AnyObject) {
        let value2: [String: String] =  ["messages": self.text.text! as String, "fromId": (FIRAuth.auth()?.currentUser?.uid)! as String, "toId": self.passedCurrentUserUid! as String, "timeStamp": String(timeStamp) as String]
        self.ref.child("userMessages").child(self.passedChatChildKey!).childByAutoId().setValue(value2)
        self.text.text = nil
        
    }
}
