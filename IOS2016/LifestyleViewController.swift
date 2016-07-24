//
//  LifestyleViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit

class LifestyleViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var data = ["Drugs", "Marijuana", "Alcohol", "Smoking", "Caffeine", "Pets"]
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
}
