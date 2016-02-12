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
    
    init()
    {
        print("data model initialised")
        loadUser()
        //loadevents()
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
            self.user = NSKeyedUnarchiver.unarchiveObjectWithData(savedUser!) as! User
        }
    }
    
    func saveEvents()
    {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(data, forKey: "Events")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadEvents()
    {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                events = unarchiver.decodeObjectForKey("Events") as! [Event]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Events.plist")
    }
    
    
}