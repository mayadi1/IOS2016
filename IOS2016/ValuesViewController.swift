//
//  ValuesViewController.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/23/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import UIKit

class ValuesViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    var data = ["Political Ideology", "Absolutist", "Anarchist", "Capitalist", "Communist", "Conservative", "Environmentalist", "Liberal", "Socialist", "Other"]
    
    var data2 = ["Party Affiliation", "Democrat", "Republican", "Independant", "Libertarian", "Green", "Constitution", "Unaffiliated"]
    
    var data3 = ["Religion", "Agnostic", "Atheist", "Buddhist", "Christian", "Christian/Baptist", "Christian/Catholic", "Christian/Mormon", "Christian/Protestant", "Christian/Unitarian", "Christian/Other", "Christian/Unitarian", "Hindu", "Jain", "Jewish", "Jewish/Conservative", "Jewish/Modern Orthodox", "Jewish/Orthodox", "Jewish/Reform", "Jewish/Other", "Muslim", "Muslim/Sunni", "Muslim/Shi`ite", "Muslim/Sufi", "Muslim/Other", "Sikh", "Taoist", "Other"]
    
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

        
    }

    //Hide Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return self.data.count
        } else if pickerView.tag == 2 {
            return self.data2.count
        } else if pickerView.tag == 3 {
            return  self.data3.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return data[row]
        } else if pickerView.tag == 2 {
            return data2[row]
        } else if pickerView.tag == 3 {
            return data3[row]
        }
        
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //info selected
    }
    

    
}//End of VC class
