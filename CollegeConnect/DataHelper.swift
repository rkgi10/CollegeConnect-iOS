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
    let dataModel = DataModel.sharedInstance
    
    init()
    {
        print("Data helper initialised")
    }
    
    
    //MARK: set user in defaults for fututre, as returned from login
    
    func setUserInDefaults(userName : String, password : String, withToken token : String)->String{
        
        
        debugPrint(token)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedUser = defaults.objectForKey("User") as? NSData {
            let user = NSKeyedUnarchiver.unarchiveObjectWithData(savedUser) as! User
            let updatedUser = user
            updatedUser.userName = userName
            updatedUser.password = password
            updatedUser.currentToken = token
            updatedUser.isLoggedIn = true
            
            let userToBeSaved = NSKeyedArchiver.archivedDataWithRootObject(updatedUser)
            defaults.setObject(userToBeSaved, forKey: "User")
        }
        else {
            let newUser = User(userName: userName, password: password)
            newUser.currentToken = token
            newUser.isLoggedIn = true
            
            let userToBeSaved = NSKeyedArchiver.archivedDataWithRootObject(newUser)
            defaults.setObject(userToBeSaved, forKey: "User")
            
            
        }
        
        
        debugPrint("Data saved")
        return "Success"
    }
    
    //MARK: save user in defaults after successful sign-up
    
    func setUserInDefaults(user : User, withToken token : String)->String{
        
        
        debugPrint(token)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedUser = defaults.objectForKey("User") as? NSData {
            var updatedUser = NSKeyedUnarchiver.unarchiveObjectWithData(savedUser) as! User
            updatedUser = user
            updatedUser.currentToken = token
            updatedUser.isLoggedIn = true
            
            let userToBeSaved = NSKeyedArchiver.archivedDataWithRootObject(updatedUser)
            defaults.setObject(userToBeSaved, forKey: "User")
            dataModel.setCurrentUser(updatedUser)
        }
        else {
            let newUser = user
            newUser.currentToken = token
            newUser.isLoggedIn = true
            
            let userToBeSaved = NSKeyedArchiver.archivedDataWithRootObject(newUser)
            defaults.setObject(userToBeSaved, forKey: "User")
            dataModel.setCurrentUser(newUser)
            
            
        }
        
        
        debugPrint("Data saved")
        return "Success"
    }

    
    
    
    
    
    func saveEventModel(events : JSON)
    {
        if let eventsArray = events.array {
        print(eventsArray.count)
            var i = 0
        for event in eventsArray {
            i++
            print(i)
//            let newEvent = Event(name: event["name"].stringValue)
//            newEvent.clubName = event["clubname"].stringValue
//            newEvent.startDate = event["sdt"].stringValue
//            newEvent.lastregtime = event["lrt"].stringValue
//            newEvent.clubId = event["club_id"].intValue
//            newEvent.verified = event["verified"].boolValue
//            newEvent.aboutEvent = event["about"].stringValue
//            newEvent.endDate = event["edt"].stringValue
//            newEvent.totalSeats = event["total_seats"].intValue
//           //TODO : figure out what this created by is
//            //newEvent.cretedby
//            newEvent.prize[0] = event["prize"].intValue
//            newEvent.fees = event["fees"].intValue
//            newEvent.contacts = [[ event["contacts"][0]["name"].stringValue, String(event["contacts"][0]["mobno"].intValue) ],[event["contacts"][1]["name"].stringValue, String(event["contacts"][1]["mobno"].intValue)]]
//            newEvent.venue = event["venue"].stringValue
//            newEvent.linkOfImageOfEvent = event["image"].stringValue
//            newEvent.availableSeats = event["available_seats"].intValue
//            newEvent.eventId = event["event_id"].intValue
//            
//            dataModel.events.append(newEvent)
            
        }
    }
    dataModel.saveEvents()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}