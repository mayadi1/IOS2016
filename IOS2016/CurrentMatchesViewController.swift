//
//  CurrentMatchesViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 9/24/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit

class CurrentMatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentMachtesCell", for: indexPath)
        cell.textLabel?.text = "test"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
