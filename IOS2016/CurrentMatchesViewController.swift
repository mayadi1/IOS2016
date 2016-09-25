//
//  CurrentMatchesViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 9/24/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CurrentMatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var embed: ChatViewController?

    @IBOutlet weak var containerView: UIView!
    let ref = FIRDatabase.database().reference()
    var usersInfo = [UsersInfo]()
    var userMessages = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.isHidden = true
        fetchUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentMachtesCell", for: indexPath)
        let user = usersInfo[indexPath.row]
        
        let url = NSURL(string: user.photo!)
        let data = NSData(contentsOf: url! as URL)
        
        let image = UIImage(data: data! as Data)
        
        cell.imageView?.image = image
        cell.imageView?.layer.cornerRadius = 20
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.masksToBounds = true
        cell.textLabel?.text = user.name

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersInfo.count
    }
    
    func fetchUsers(){
        let condition = ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("chatPointerTo")
        
        condition.observe(.childAdded, with:  { (snapshot) in
            if (snapshot.exists()){
                let condition2 =  self.ref.child("messages").child(snapshot.value as! String)
                
                condition2.observe(.value, with:  { (snapshot) in
                    let info = snapshot.value as! NSDictionary
                  
                    self.userMessages.append(info["userMessages"] as! String)
                    
                    let condition3 = self.ref.child("users").child(info["toId"] as! String)
                    condition3.observeSingleEvent(of: .value, with: { (FIRDataSnapshot) in
                        let value = FIRDataSnapshot.value
                        let each = value as! NSDictionary
                        self.usersInfo.append(UsersInfo(tempName: each["username"] as! String, tempPhoto: each["userProfilePic"] as! String, tempUID: each["useruid"] as! String, tempAge: each["age"] as! String, tempFollow: each["follow"] as! String, tempHeight: each["height"] as! String, tempSchool: each["school"] as! String, tempJob: each["job"] as! String, tempUserType: each["userType"] as! String, tempBio: each["bio"] as! String, tempValue1: each["value1"] as! String, tempValue2: each["value2"] as! String, tempValue3: each["value3"] as! String))
                        self.tableView.reloadData()
                    })
                })
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        containerView.isHidden = false
        let messages = ref.child("userMessages").child(userMessages[indexPath.row])
        messages.observe(.value, with:  { (snapshot) in
         
            var info = snapshot.value as! NSDictionary
            let info2 = info.allValues
            info = info2[0] as! NSDictionary
           
            print(info["messages"] as! String)
            
            self.embed?.passedMessages.append(info["messages"] as! String)
            self.embed?.tableView.reloadData()

        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "chatSeg"){
            embed = segue.destination as? ChatViewController
        }
    }
}//End of CurrentMatchesViewController class
