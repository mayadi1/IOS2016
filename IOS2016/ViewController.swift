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
    
    @IBOutlet weak var nameandage: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var political: UITextField!
    
    @IBOutlet weak var party: UITextField!
    
    @IBOutlet weak var labelll: UILabel!
    
    
    var count = 0
    
    @IBOutlet weak var down: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
              
                
                if self.count == 0{
                self.nameandage.text = "Alex, 30"
                self.location.text = "San jose"
                self.political.text = " "
                self.party.text = " "
                self.labelll.text = "6'' 4'"
                
                self.mainImageView.image = UIImage.init(named: "url-28")
                self.count = self.count + 1
                    return
                }
                
                if self.count == 1{
                    self.nameandage.text = "Trump, 90"
                    self.location.text = "Chicago"
                    self.political.text = " "
                    self.party.text = " "
                    self.labelll.text = "7'' 4'"
                    
                    self.mainImageView.image = UIImage.init(named: "photo")
                    self.count = self.count + 1
                    return
                }
                
                
                
                if self.count == 2{
                    self.nameandage.text = "Mohamed, 21"
                    self.location.text = "San Francisco"
                    self.political.text = "Liberal"
                    self.party.text = "Democrat"
                    self.labelll.text = "5'' 11'"
                    
                    self.mainImageView.image = UIImage.init(named: "Screen Shot 2016-07-12 at 9.03.51 AM")
                    self.count = 0
                    return
                }
                

            case UISwipeGestureRecognizerDirection.Left:
                print("Swiped left")
                self.down.hidden = false
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
                

                
                if self.count == 0{
                    self.nameandage.text = "Alex, 30"
                    self.location.text = "San jose"
                    self.political.text = " "
                    self.party.text = " "
                    self.labelll.text = "6'' 4'"
                    
                    self.mainImageView.image = UIImage.init(named: "url-28")
                    self.count = self.count + 1
                    return
                }
                
                if self.count == 1{
                    self.nameandage.text = "Trump, 90"
                    self.location.text = "Chicago"
                    self.political.text = " "
                    self.party.text = " "
                    self.labelll.text = "7'' 4'"
                    
                    self.mainImageView.image = UIImage.init(named: "photo")
                    self.count = self.count + 1
                    return
                }
                
                
                
                if self.count == 2{
                    self.nameandage.text = "Mohamed, 21"
                    self.location.text = "San Francisco"
                    self.political.text = "Liberal"
                    self.party.text = "Democrat"
                    self.labelll.text = "5'' 11'"
                    
                    self.mainImageView.image = UIImage.init(named: "Screen Shot 2016-07-12 at 9.03.51 AM")
                    self.count = 0
                    return
                }

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
