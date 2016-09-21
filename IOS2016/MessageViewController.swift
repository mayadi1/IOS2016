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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let condition = FIRDatabase.database().reference().child("chat").child("message")
        
        
        condition.observe(.childAdded, with:  { (snapshot) in
            
            
            
            print(snapshot)
            
            let arr = snapshot.value as! [String: String]
            let foo = arr["text"] as String!
            
            print(foo)
            
            
            self.addMessage(self.senderId, text: foo!)
                self.reloadMessagesView()
            })
        
        
        
        
//        self.user?.displayName
//        self.user?.uid
        
        setupBubbles()
        self.setup()
//        addMessages()
//        self.addDemoMessages()
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
    }

    fileprivate func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory?.outgoingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleBlue())
        incomingBubbleImageView = factory?.incomingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleLightGray())
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
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
            as! JSQMessagesCollectionViewCell
        
        let message = messages[(indexPath as NSIndexPath).item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = UIColor.white
        } else {
            cell.textView!.textColor = UIColor.black
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // messages from someone else
        addMessage("foo", text: "Hey person!")
        // messages sent from local sender
        addMessage(senderId, text: "Yo!")
        addMessage(senderId, text: "I like turtles!")
        // animates the receiving of a new message on the view
        finishReceivingMessage()
    }
  
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }

    func addMessage(_ id: String, text: String) {
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        messages.append(message!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!,
                                     senderDisplayName: String!, date: Date!) {
        let messageItem = [ // 2
            "text": text,
            "senderId": senderId
        ]
        
        let itemRef = FIRDatabase.database().reference().child("chat").child("message").childByAutoId().setValue(messageItem)
        
        // 4
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        // 5
        finishSendingMessage()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
