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
        
        
        debugPrint("User saved")
        return "Success"
    }

    //MARK: Saving clubs info
    func saveClubsModel(clubs : JSON)->String {
        var clubsModel : [Club] = []
        
        if let clubsArray = clubs.array {

            for club in clubsArray {
                let newClub = Club(name: club["name"].stringValue)
                newClub.about = club["about"].stringValue
                newClub.id = club["club_id"].intValue
                let clubAdmins = club["admins"].arrayValue
                
                for value in clubAdmins {
                    let adminName = value["name"].stringValue
                    let adminNumber = value["mobno"].stringValue
                    let adminArray = [adminName , adminNumber]
                    newClub.admins.append(adminArray)
                }
                newClub.imageRemoteUrl = club["image"].stringValue
                
                //finally add the club to clubmodel
                clubsModel.append(newClub)
            }
        }
        dataModel.clubs = clubsModel
        dataModel.saveClubs()
        debugPrint("Clubs Saved")
        return "Success"
    }
    
    
    
    
    func saveEventModel(events : JSON)->String
    {
        var eventsModel : [Event] = []
        var truefalsedict = ["True" : true, "False" : false]
        
        if let eventsArray = events.array {
            
            for event in eventsArray {
                let newEvent = Event(name: event["name"].stringValue)
                newEvent.clubName = event["clubname"].stringValue
                newEvent.startDate = event["sdt"].stringValue
                newEvent.lastregtime = event["lrt"].stringValue
                newEvent.clubId = event["club_id"].intValue
                newEvent.aboutEvent = event["about"].stringValue
                newEvent.verified = truefalsedict[event["verified"].stringValue]
                newEvent.endDate = event["edt"].stringValue
                newEvent.fees = event["fees"].intValue
                newEvent.creatorId = event["createdby"].intValue
                newEvent.imageRemoteUrl = event["image"].stringValue
                newEvent.prize = [event["prize"].intValue]
                newEvent.venue = event["venue"].stringValue
                
                let contactsArray = event["contacts"].arrayValue
                for contact in contactsArray {
                    let contactName = contact["name"].stringValue
                    let contactNumber = contact["mobno"].stringValue
                    let newContact = [contactName, contactNumber]
                    newEvent.contacts.append(newContact)
                }
                
                newEvent.availableSeats = event["available_seats"].intValue
                newEvent.totalSeats = event["total_seats"].intValue
                newEvent.eventId = event["event_id"].intValue
                
                eventsModel.append(newEvent)
            }
            dataModel.events = eventsModel
            dataModel.saveEvents()
            return "Success"
        }
        
        debugPrint("event array not found. Probably system error")
        return "Failure"
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
}