//
//  EthnicityViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit

class EthnicityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var data = ["Asian", "Black / African Descent", "Jewish", "Latino/Hispanic", "Middle Eastern", "Pacific Islander", "South Asian", "Native American / Aboriginal", "White / Caucasian", "Other"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.data[indexPath.row]
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    }

   
}
