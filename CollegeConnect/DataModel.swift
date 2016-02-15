//
//  EventModel.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 10/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
class DataModel {
    
    static let sharedInstance = DataModel()
    
    var events : [Event] = []
    var user : User = User(userName: "Guest", password: "")
    var colleges : [String] = ["Choose Your College","NIT-Surat","Other-College","Not a College Student"]
    var SVNIThostels = ["Choose Your Hostel","Bhabha Bhavan","Gajjar Bhavan","Mother Teresa Bhavan","Sarabhai Bhavan","Tagore Bhavan","Nehru Bhavan","Raman Bhavan","Swami Vivekanand Bhavan"]
    var clubs : [Club] = []
    
    init()
    {
        print("data model initialised")
        loadData()
    }
    
    
    
    //MARK: Overall saving related functions
    
    func saveData()
    {
        saveClubs()
       // saveEvents()
    }
    
    func loadData()
    {
        loadUser()
       // loadEvents()
        loadClubs()
    }
    
    //MARK: Event related functions
    func saveEvents()
    {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(events, forKey: "Events")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath("Events"), atomically: true)
        debugPrint("saved events to disk")
    }
    
    func loadEvents()
    {
        let path = dataFilePath("Events")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                events = unarchiver.decodeObjectForKey("Events") as! [Event]
                unarchiver.finishDecoding()
            }
        }
    }
    
    
    
    //MARK: User-related Methods
    
    func getCurrentUser()->User {
        return self.user
    }
    
    func setCurrentUser(updatedUser : User)
    {
      self.user = updatedUser
      self.user.isLoggedIn = true
    }
    
    
    func isCurrentUserGuestUser()->Bool {
        if self.user.userName == "Guest" && self.user.password == "" {
            return true
        }
        else
        {
            return false
        }
    }
    
    func loadUser()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let savedUser = defaults.objectForKey("User") as? NSData
        
        if savedUser == nil {
            return
        }
        else
        {
            setCurrentUser( NSKeyedUnarchiver.unarchiveObjectWithData(savedUser!) as! User)
        }
    }
    
    
    //MARK: clubs related functions
    func saveClubs()
    {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(clubs, forKey: "Clubs")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath("Clubs"), atomically: true)
        debugPrint("saved clubs to disk")
    }
    
    func loadClubs()
    {
        let path = dataFilePath("Clubs")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                clubs = unarchiver.decodeObjectForKey("Clubs") as! [Club]
                unarchiver.finishDecoding()
                debugPrint("loaded clubs from disk")
            }
        }
        
    }
    
    
    //MARK: filepath helper functions
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath(fileName : String) -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent(fileName + ".plist")
    }
    
    
}