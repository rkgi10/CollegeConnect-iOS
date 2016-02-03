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
struct Event {
    
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
    var occupiedSeats : Int?
    var lastregtime : Int?
    var imageOfEvent : UIImage? {
        didSet{
            self.eventColors = self.imageOfEvent?.getColors(CGSize(width: 250, height: 250))
            }
    }
    var verified : Bool?
    var eventColors : UIImageColors?
    
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
    
    
    
}