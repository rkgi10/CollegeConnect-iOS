//
//  Event.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 30/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import UIKit

var clubIdDict = [1 : "ACM", 2 : "WebDevLabs"]
class Event :NSObject, NSCoding {
    
    var clubName : String?
    var clubId : Int?
    var eventId : Int?
    var name : String!
    var timeanddate : NSDate?
    var startDate : String?
    var endDate : String?
    var aboutEvent : String?
    var contacts : [[String]] = []
    var venue : String!
    var noOfLikes : Int?
    var totalSeats : Int?
    //var occupiedSeats : Int?
    var lastregtime : String?
    var imageOfEvent : UIImage?
    var imageRemoteUrl : String?
    var imageLocalUrl : String?
    var verified : Bool?
    var eventColors : UIImageColors?
    var linkOfImageOfEvent : String?
    var prize : [Int] = []
    var fees : Int?
    var availableSeats : Int?
    var creatorId : Int?
    
    required init?(coder aDecoder: NSCoder) {
        clubName = aDecoder.decodeObjectForKey("clubName") as? String
        clubId = aDecoder.decodeObjectForKey("clubId") as? Int
        eventId = aDecoder.decodeObjectForKey("eventId") as? Int
        name = aDecoder.decodeObjectForKey("name") as! String
        timeanddate = aDecoder.decodeObjectForKey("timeanddate") as? NSDate
        startDate = aDecoder.decodeObjectForKey("startDate") as? String
        endDate = aDecoder.decodeObjectForKey("endDate") as? String
        aboutEvent = aDecoder.decodeObjectForKey("aboutEvent") as? String
        contacts = aDecoder.decodeObjectForKey("contacts") as! [[String]]
        venue = aDecoder.decodeObjectForKey("venue") as! String
        noOfLikes = aDecoder.decodeObjectForKey("noOfLikes") as? Int
        totalSeats = aDecoder.decodeObjectForKey("totalSeats") as? Int
        availableSeats = aDecoder.decodeObjectForKey("occupiedSeats") as? Int
        lastregtime = aDecoder.decodeObjectForKey("lastregtime") as? String
        imageOfEvent = aDecoder.decodeObjectForKey("imageOfEvent") as? UIImage
        verified = aDecoder.decodeObjectForKey("verified") as? Bool
       // eventColors = aDecoder.decodeObjectForKey("eventColors") as? UIImageColors
        linkOfImageOfEvent = aDecoder.decodeObjectForKey("linkOfImageOfEvent") as? String
        imageRemoteUrl = aDecoder.decodeObjectForKey("imageRemoteUrl") as? String
        imageLocalUrl = aDecoder.decodeObjectForKey("imageLocalUrl") as? String
        creatorId = aDecoder.decodeObjectForKey("creatorId") as? Int
        
        super.init()
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(clubName, forKey: "clubName")
        aCoder.encodeObject(clubId, forKey: "clubId")
        aCoder.encodeObject(eventId, forKey: "eventId")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(timeanddate, forKey: "timeanddate")
        aCoder.encodeObject(startDate, forKey: "startDate")
        aCoder.encodeObject(endDate, forKey: "endDate")
        aCoder.encodeObject(aboutEvent, forKey: "aboutEvent")
        aCoder.encodeObject(contacts, forKey: "contacts")
        aCoder.encodeObject(venue, forKey: "venue")
        aCoder.encodeObject(noOfLikes, forKey: "noOfLikes")
        aCoder.encodeObject(totalSeats, forKey: "totalSeats")
        aCoder.encodeObject(availableSeats, forKey: "occupiedSeats")
        aCoder.encodeObject(lastregtime, forKey: "lastregtime")
        aCoder.encodeObject(imageOfEvent, forKey: "imageOfEvent")
        aCoder.encodeObject(verified, forKey: "verified")
        //aCoder.encodeObject(eventColors, forKey: "")
        aCoder.encodeObject(linkOfImageOfEvent, forKey: "linkOfImageOfEvent")
        aCoder.encodeObject(imageRemoteUrl, forKey: "imageRemoteUrl")
        aCoder.encodeObject(imageLocalUrl, forKey: "imageLocalUrl")
        aCoder.encodeObject(creatorId, forKey: "creatorId")
    }
    
    init(name : String , aboutEvent : String, contacts : [[String]], startDate : String, endDate : String, venue : String, clubId : Int)
    {
        self.name = name
        self.aboutEvent = aboutEvent
        self.contacts = contacts
        self.startDate = startDate
        self.endDate = endDate
        self.venue = venue
        self.clubId = clubId
        self.clubName = clubIdDict[clubId]
    }
    
    init(name : String , aboutEvent : String, contacts : [[String]], startDate : String, endDate : String, venue : String, clubId : Int, imageOfEvent : String)
    {
        self.name = name
        self.aboutEvent = aboutEvent
        self.contacts = contacts
        self.startDate = startDate
        self.endDate = endDate
        self.venue = venue
        self.clubId = clubId
        self.clubName = clubIdDict[clubId]
        self.imageOfEvent = UIImage(named: imageOfEvent)
    }
    
    init(name : String , aboutEvent : String, contacts : [[String]], startDate : String, endDate : String, venue : String, clubName : String, imageOfEvent : String)
    {
        self.name = name
        self.aboutEvent = aboutEvent
        self.contacts = contacts
        self.startDate = startDate
        self.endDate = endDate
        self.venue = venue
        self.clubName = clubName
        self.imageOfEvent = UIImage(named: imageOfEvent)
    }
    
    init(name : String) {
        self.name = name
    }
    
    
    
    
}