
//
//  ReligionViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit

class ReligionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var data = ["Religion", "Agnostic", "Atheist", "Buddhist", "Christian", "Christian/Baptist", "Christian/Catholic", "Christian/Mormon", "Christian/Protestant", "Christian/Unitarian", "Christian/Other", "Christian/Unitarian", "Hindu", "Jain", "Jewish", "Jewish/Conservative", "Jewish/Modern Orthodox", "Jewish/Orthodox", "Jewish/Reform", "Jewish/Other", "Muslim", "Muslim/Sunni", "Muslim/Shi`ite", "Muslim/Sufi", "Muslim/Other", "Sikh", "Taoist", "Other"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        
        cell.textLabel?.text = self.data[(indexPath as NSIndexPath).row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
}

}
