//
//  UsersInfo.swift
//  IOS2016
//
//  Created by Mohamed Ayadi on 7/29/16.
//  Copyright © 2016 IOS2016. All rights reserved.
//

import Foundation
import UIKit

class UsersInfo: NSObject {
    

        
        var name: String?
        var photo: String?
        var uid: String?
    init(tempName: String, tempPhoto: String, tempUID: String){
        
            self.name = tempName
            self.photo = tempPhoto
            self.uid = tempUID
        }
        
        
}