//
//  NewMatchesViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 9/24/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SideMenu

class NewMatchesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var profileInfoView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let usersRef = FIRDatabase.database().reference().child("users")
    var newMatchesUsersInfo = [UsersInfo]()
    var embed: newMatchesUserInfoTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileInfoView.isHidden = true
        self.profileInfoView.layer.cornerRadius = 20;
        self.profileInfoView.clipsToBounds = true;
        retrieveNewMatches()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newMatchesCell", for: indexPath)
        
        let user = newMatchesUsersInfo[indexPath.row]
        
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
        return newMatchesUsersInfo.count
    }
    
    func retrieveNewMatches(){
        let condition = usersRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("newLike")
        
        condition.observe(.childAdded, with:  { (snapshot) in
            
            let condition2 = self.usersRef.child(snapshot.value as! String)
            
            condition2.observeSingleEvent(of: .value, with: { (FIRDataSnapshot) in
                
                let value = FIRDataSnapshot.value
                
                let each = value as! NSDictionary
                
                self.newMatchesUsersInfo.append(UsersInfo(tempName: each["username"] as! String, tempPhoto: each["userProfilePic"] as! String, tempUID: each["useruid"] as! String, tempAge: each["age"] as! String, tempFollow: each["follow"] as! String, tempHeight: each["height"] as! String, tempSchool: each["school"] as! String, tempJob: each["job"] as! String, tempUserType: each["userType"] as! String, tempBio: each["bio"] as! String, tempValue1: each["value1"] as! String, tempValue2: each["value2"] as! String, tempValue3: each["value3"] as! String))
                
                self.tableView.reloadData()
            })
        })
    }
    //A method with a completion handler to get the image data from  url
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        profileInfoView.isHidden = false
        self.hideProfileInfoViewWhenTappedAround()
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        self.embed?.image.image = currentCell.imageView?.image
        self.embed?.name.text = currentCell.textLabel?.text
        self.embed?.age.text = self.newMatchesUsersInfo[indexPath.row].age
        self.embed?.height.text = self.newMatchesUsersInfo[indexPath.row].height
        self.embed?.job.text = self.newMatchesUsersInfo[indexPath.row].job
        self.embed?.school.text = self.newMatchesUsersInfo[indexPath.row].school
        self.embed?.value1.text = self.newMatchesUsersInfo[indexPath.row].value1
        self.embed?.value2.text = self.newMatchesUsersInfo[indexPath.row].value2
        self.embed?.value3.text = self.newMatchesUsersInfo[indexPath.row].value3
        self.embed?.bio.text = self.newMatchesUsersInfo[indexPath.row].bio
        self.embed?.uid.text = self.newMatchesUsersInfo[indexPath.row].uid

        
    }
    
    
    func hideProfileInfoViewWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissProfileInfoView))
        view.addGestureRecognizer(tap)
    }
    
    func dismissProfileInfoView() {
        self.profileInfoView.isHidden = true
        print("cani do it here?")
        view.removeGestureRecognizer((self.view.gestureRecognizers?[0])!)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "userInformation"){
            embed = segue.destination as? newMatchesUserInfoTableViewController
        }
        
    }
}

