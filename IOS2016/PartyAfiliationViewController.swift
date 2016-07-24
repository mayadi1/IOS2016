//
//  PartyAfiliationViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit

class PartyAfiliationViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    var data = ["Party Affiliation", "Democrat", "Republican", "Independant", "Libertarian", "Green", "Constitution", "Unaffiliated"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.data[indexPath.row]
        
        
        return cell
    }
    




}//End of the PartyA VC
