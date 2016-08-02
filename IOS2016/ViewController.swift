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
        
        

        
        
        self.likeImage.hidden = true
        
        self.down.hidden = true
        
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeUp)
        
        
        
        
        if FIRAuth.auth()?.currentUser != nil{
            let ref = FIRDatabase.database().reference()
            
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID!).child("userProfilePic").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                // Get user value
                
                let filePath = snapshot.value as! String
                
                let url = NSURL(string: filePath)
                if let data = NSData(contentsOfURL: url!){
                    
                    
                    UIImage.init(data: data)
                    
                    var image = UIImage.init(data: data)
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    var imgData = UIImageJPEGRepresentation(image!, 1)
                    defaults.setObject(imgData, forKey: "image")
                    
                    
                    
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
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func ViewButtonTapped(sender: AnyObject) {
        
        print("View is tapped!")
        performSegueWithIdentifier("showInfo", sender: nil)
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showInfo"{
            let vc = segue.destinationViewController as! UIViewController
            let controller = vc.popoverPresentationController
            
            if controller != nil{
                controller!.delegate = self
                
            }
            
            
        }
    }
    
    @IBAction func test(sender: AnyObject) {
        
        performSegueWithIdentifier("showInfo", sender: nil)
        
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        
        
        return .None
    }
    
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                
                
                self.likeImage.hidden = false
                
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
                print("Swiped right")
                
                
                self.changeUser()

                
                
            case UISwipeGestureRecognizerDirection.Left:
                print("Swiped left")
                self.down.hidden = false
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
                
              self.changeUser()
              
            default:
                break
            }
        }
    }
    
    
    
    func dismissAlert()
    {
        self.likeImage.hidden = true
        self.down.hidden = true
        
    }
    
    
    
    //Retrive users
    
    func retrieveUsers(){
        
        
        
        self.usersRef.observeEventType(.Value, withBlock:  { (snapshot) in
            
            let value = snapshot.value
            
            let tempProfileInfoArray = value as! NSDictionary
            
            
            let usersValues = tempProfileInfoArray.allValues
            
            for each in usersValues{
                
                
                self.usersInfo.append(UsersInfo(tempName: each["username"] as! String, tempPhoto: each["userProfilePic"] as! String, tempUID: each["useruid"] as! String))
                
        
                
            }
            
            
            self.activityIndicator.stopAnimating()
            
            let firstUser = self.usersInfo.first
            
            
            self.nameandage.text = firstUser?.name
            self.location.text = "Atlanta"
            self.political.text = "Conservative"
            self.party.text = "Baptist"
            self.labelll.text = "6'1''"
            
            let filePath = firstUser?.photo
            
            let url = NSURL(string: filePath!)
            
            if let data = NSData(contentsOfURL: url!){
                
                
                dispatch_async(dispatch_get_main_queue(), { 
                     self.mainImageView.image = UIImage.init(data: data)
                })
               
                
            }

        })
        
        
    }
    
    

    func changeUser(){
        
        
        
        
        self.count = self.count + 1
        
        
        if self.count >= self.usersInfo.count{
            
            
            let alertController = UIAlertController(title: nil, message: "Came back later for new users", preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: "Okay", style: .Default) { (action:UIAlertAction!) in
                
                self.likeImage.removeFromSuperview()
                self.down.removeFromSuperview()
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
            
            
            return
            
        }
        
        
        
        let tempUser = self.usersInfo[self.count]
        
        
        self.nameandage.text = tempUser.name
        self.location.text = "Atlanta"
        self.political.text = "Conservative"
        self.party.text = "Baptist"
        self.labelll.text = "6'1''"
        
        let filePath = tempUser.photo
        
        let url = NSURL(string: filePath!)
        
        if let data = NSData(contentsOfURL: url!){
            
            
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
