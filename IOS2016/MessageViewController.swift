//
//  MessageViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MessageViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    let user = FIRAuth.auth()?.currentUser
//    let rootRef = FIRDatabase.database().reference()
    var messageRef = FIRDatabase.database().reference().child("users").setValue("messages")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.user?.displayName
//        self.user?.uid
        
        setupBubbles()
        self.setup()
//        addMessages()
//        self.addDemoMessages()
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    }

    private func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleBlueColor())
        incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleLightGrayColor())
    }
    
    func reloadMessagesView() {
        self.collectionView?.reloadData()
    }
//        func addMessages() {
//            for i in 1...10 {
//                let sender = (i%2 == 0) ? "Server" : self.senderId
//                let messageContent = "Message nr. \(i)"
//                let message = JSQMessage(senderId: sender, displayName: sender, text: messageContent)
//                self.messages += [message]
//            }
//            self.reloadMessagesView()
//    }
//    
    func setup() {
        self.senderId = self.user?.uid
        self.senderDisplayName = self.user?.displayName
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
            as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = UIColor.whiteColor()
        } else {
            cell.textView!.textColor = UIColor.blackColor()
        }
        return cell
    }

    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // messages from someone else
        addMessage("foo", text: "Hey person!")
        // messages sent from local sender
        addMessage(senderId, text: "Yo!")
        addMessage(senderId, text: "I like turtles!")
        // animates the receiving of a new message on the view
        finishReceivingMessage()
    }
  
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }

    func addMessage(id: String, text: String) {
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        messages.append(message)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
//    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!,
//                                     senderDisplayName: String!, date: NSDate!) {
//        let messageItem = [ // 2
//            "text": text,
//            "senderId": senderId
//        ]
//        
//        let itemRef = FIRDatabase.database().reference().child("users").child("message").setValue(messageItem)
//        
//        // 4
//        JSQSystemSoundPlayer.jsq_playMessageSentSound()
//        // 5
//        finishSendingMessage()
//    }
//    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
