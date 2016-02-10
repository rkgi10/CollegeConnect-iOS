//
//  DataHelper.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 07/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import SwiftyJSON
class DataHelper {
    
    static let sharedInstance = DataHelper()
    
    init()
    {
        print("Data helper initialised")
    }
    
    func setUserInDefaults(userName : String, password : String, withToken token : String)->String{
        
        
        debugPrint(token)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedUser = defaults.objectForKey("User") as? NSData {
            let user = NSKeyedUnarchiver.unarchiveObjectWithData(savedUser) as! User
            var updatedUser = user
            updatedUser.userName = userName
            updatedUser.password = password
            updatedUser.currentToken = token
            updatedUser.isLoggedIn = true
            
            let userToBeSaved = NSKeyedArchiver.archivedDataWithRootObject(updatedUser)
            defaults.setObject(userToBeSaved, forKey: "User")
        }
        else {
            var newUser = User(userName: userName, password: password)
            newUser.currentToken = token
            newUser.isLoggedIn = true
            
            let userToBeSaved = NSKeyedArchiver.archivedDataWithRootObject(newUser)
            defaults.setObject(userToBeSaved, forKey: "User")
            
            
        }
        
        
        debugPrint("Data saved")
        return "Success"
    }
    
    func saveEventModel(events : JSON)
    {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}