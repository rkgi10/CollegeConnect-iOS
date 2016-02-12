//
//  User.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 06/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation

class User : NSObject, NSCoding {
    var isLoggedIn : Bool?
    var userName : String!
    var password : String!
    var rollNo : String?
    var collegeName : String?
    var hostelName : String?
    var currentToken : String?
    var signedUpUsingApp : Bool?
    var isAdminOfAClub : Bool?
    var fullName : String?
    var mobileNumber : String?
    var clubIdsOfWhichUserIsAdmin : [Int] = []
    var hosteliteOrLocalite : Bool?
    
    
    required init?(coder aDecoder: NSCoder) {
        isLoggedIn = aDecoder.decodeObjectForKey("isLoggedIn") as? Bool
        userName = aDecoder.decodeObjectForKey("userName") as! String
        password = aDecoder.decodeObjectForKey("password") as! String
        rollNo = aDecoder.decodeObjectForKey("rollNo") as? String
        collegeName = aDecoder.decodeObjectForKey("collegeName") as? String
        hostelName = aDecoder.decodeObjectForKey("hostelName") as? String
        currentToken = aDecoder.decodeObjectForKey("currentToken") as? String
        signedUpUsingApp = aDecoder.decodeObjectForKey("signedUpUsingApp") as? Bool
        isAdminOfAClub = aDecoder.decodeObjectForKey("isAdminOfAClub") as? Bool
        clubIdsOfWhichUserIsAdmin = aDecoder.decodeObjectForKey("clubIdsOfWhichUserIsAdmin") as! [Int]
        fullName = aDecoder.decodeObjectForKey("fullName") as? String
        mobileNumber = aDecoder.decodeObjectForKey("mobileNumber") as? String
        hosteliteOrLocalite = aDecoder.decodeObjectForKey("hosteliteOrLocalite") as? Bool
        
        super.init()
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(isLoggedIn, forKey: "isLoggedIn")
        aCoder.encodeObject(userName, forKey: "userName")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(rollNo, forKey: "rollNo")
        aCoder.encodeObject(collegeName, forKey: "collegeName")
        aCoder.encodeObject(hostelName, forKey: "hostelName")
        aCoder.encodeObject(currentToken, forKey: "currentToken")
        aCoder.encodeObject(signedUpUsingApp, forKey: "signedUpUsingApp")
        aCoder.encodeObject(isAdminOfAClub, forKey: "isAdminOfAClub")
        aCoder.encodeObject(clubIdsOfWhichUserIsAdmin, forKey: "clubIdsOfWhichUserIsAdmin")
        aCoder.encodeObject(fullName, forKey: "fullName")
        aCoder.encodeObject(mobileNumber, forKey: "mobileNumber")
        aCoder.encodeObject(hosteliteOrLocalite, forKey: "hosteliteOrLocalite")
    }
    
    init(userName : String, password : String)
    {
        self.userName = userName
        self.password = password
        
        super.init()
    }
}
