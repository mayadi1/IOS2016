//
//  ChatViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 9/25/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var passedMessages = [String]()
    
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
}
