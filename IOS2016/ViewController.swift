//
//  ViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/22/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UIPopoverPresentationControllerDelegate{
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
