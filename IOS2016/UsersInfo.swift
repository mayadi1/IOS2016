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
    var age: String?
    var name: String?
    var photo: String?
    var uid: String?
    var bio: String?
    var follow: String?
    var height: String?
    var job: String?
    var school: String?
    var userType: String?
    var value1: String?
    var value2: String?
    var value3: String?
    
    init(tempName: String, tempPhoto: String, tempUID: String, tempAge: String, tempFollow: String, tempHeight: String, tempSchool: String, tempJob: String, tempUserType: String, tempBio: String, tempValue1: String, tempValue2: String,tempValue3: String){
 
        self.name = tempName
        self.photo = tempPhoto
        self.uid = tempUID
        self.age = tempAge
        self.follow = tempFollow
        self.height = tempHeight
        self.school = tempSchool
        self.job = tempJob
        self.userType = tempUserType
        self.bio = tempBio
        self.value1 = tempValue1
        self.value2 = tempValue2
        self.value3 = tempValue3

        }
}
