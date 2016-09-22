//
//  ViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/22/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameandage: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var political: UITextField!
    
    @IBOutlet weak var party: UITextField!
    
    @IBOutlet weak var labelll: UILabel!
    
    let usersRef = FIRDatabase.database().reference().child("users")
    
    
    var count = 0
    
    var usersInfo = [UsersInfo]()
    
    
    @IBOutlet weak var down: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        self.retrieveUsers()
        
        

        
        
        self.likeImage.isHidden = true
        
        self.down.isHidden = true
        
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeUp)
        
        
        
        
        if FIRAuth.auth()?.currentUser != nil{
            let ref = FIRDatabase.database().reference()
            
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID!).child("userProfilePic").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                
                let filePath = snapshot.value as! String
                
                let url = URL(string: filePath)
                if let data = try? Data(contentsOf: url!){
                    
                    
                    UIImage.init(data: data)
                    
                    let image = UIImage.init(data: data)
                    
                    let defaults = UserDefaults.standard
                    let imgData = UIImageJPEGRepresentation(image!, 1)
                    defaults.set(imgData, forKey: "image")
                    
                    
                    
                }
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
        }
        
        /// let ref = FIRDatabase.database().reference()
        
        
        self.hideKeyboardWhenTappedAround()
        
        self.mainImageView.layer.cornerRadius = 20;
        self.mainImageView.clipsToBounds = true;
        
        self.infoView.layer.cornerRadius = 20;
        self.infoView.clipsToBounds = true;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    //Hide Status bar
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    @IBAction func ViewButtonTapped(_ sender: AnyObject) {
        
        print("View is tapped!")
        performSegue(withIdentifier: "showInfo", sender: nil)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo"{
            let vc = segue.destination 
            let controller = vc.popoverPresentationController
            
            if controller != nil{
                controller!.delegate = self
                
            }
            
            
        }
    }
    
    @IBAction func test(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "showInfo", sender: nil)
        
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle{
        
        
        return .none
    }
    
    
    
    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                
                
                self.likeImage.isHidden = false
                
                var timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
                print("Swiped right")
                
                
                self.changeUser()

                
                
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                self.down.isHidden = false
                var timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
                
              self.changeUser()
              
            default:
                break
            }
        }
    }
    
    
    
    func dismissAlert()
    {
        self.likeImage.isHidden = true
        self.down.isHidden = true
        
    }
    
    
    
    //Retrive users
    
    func retrieveUsers(){
        
        
        
        self.usersRef.observe(.value, with:  { (snapshot) in
            
            let value = snapshot.value
            
            let tempProfileInfoArray = value as! NSDictionary
            
            
            let usersValues = tempProfileInfoArray.allValues
            
            
            for eachh in usersValues{
                
                
                let each: NSDictionary = eachh as! NSDictionary
                self.usersInfo.append(UsersInfo(tempName: each["username"] as! String, tempPhoto: each["userProfilePic"] as! String, tempUID: each["useruid"] as! String, tempAge: each["age"] as! String, tempFollow: each["follow"] as! String, tempHeight: each["height"] as! String, tempSchool: each["school"] as! String, tempJob: each["job"] as! String, tempUserType: each["userType"] as! String, tempBio: each["bio"] as! String, tempValue1: each["value1"] as! String, tempValue2: each["value2"] as! String, tempValue3: each["value3"] as! String))
                
            }
            
            
            self.activityIndicator.stopAnimating()
            
            let firstUser = self.usersInfo.first
            
            
            self.nameandage.text = firstUser?.name
            self.location.text = firstUser?.value1
            self.political.text = firstUser?.value2
            self.party.text = firstUser?.value3
            self.labelll.text = firstUser?.height
            
            let filePath = firstUser?.photo
            
            let url = URL(string: filePath!)
            
            if let data = try? Data(contentsOf: url!){
                
                
                DispatchQueue.main.async(execute: { 
                     self.mainImageView.image = UIImage.init(data: data)
                })
               
                
            }

        })
        
        
    }
    
    

    func changeUser(){
        
        
        
        
        self.count = self.count + 1
        
        
        if self.count >= self.usersInfo.count{
            
            self.dismissAlert()
            
            let alertController = UIAlertController(title: nil, message: "Came back later for new users", preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: "Okay", style: .default) { (action:UIAlertAction!) in
                
                self.likeImage.removeFromSuperview()
                self.down.removeFromSuperview()
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
            
            return
            
        }
        
        
        
        let tempUser = self.usersInfo[self.count]
        
        
        self.nameandage.text = tempUser.name
        self.location.text = tempUser.value1
        self.political.text = tempUser.value2
        self.party.text = tempUser.value3
        self.labelll.text = tempUser.height
        
        let filePath = tempUser.photo
        
        let url = URL(string: filePath!)
        
        if let data = try? Data(contentsOf: url!){
            
            
            self.mainImageView.image = UIImage.init(data: data)
            
        }
    }
    
    
    
}//End of the VC class

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
}//End of the extension
