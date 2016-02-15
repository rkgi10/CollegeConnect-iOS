//
//  Club.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 14/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import UIKit

class Club : NSObject, NSCoding {
    
    var name = ""
    var id : Int?
    var imageRemoteUrl : String?
    var imageLocalUrl : String?
    var admins : [[String]] = []
    var events : [Int] = []
    var about : String?
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(imageLocalUrl, forKey: "imageLocalUrl")
        aCoder.encodeObject(admins, forKey: "admins")
        aCoder.encodeObject(events, forKey: "events")
        aCoder.encodeObject(about, forKey: "about")
        aCoder.encodeObject(imageRemoteUrl, forKey: "imageRemoteUrl")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        id = aDecoder.decodeObjectForKey("id") as? Int
        imageLocalUrl = aDecoder.decodeObjectForKey("imageLocalUrl") as? String
        admins = aDecoder.decodeObjectForKey("admins") as! [[String]]
        events = aDecoder.decodeObjectForKey("events") as! [Int]
        about = aDecoder.decodeObjectForKey("about") as? String
        imageRemoteUrl = aDecoder.decodeObjectForKey("imageRemoteUrl") as? String
        
        super.init()
    }
    
    init(name : String) {
        self.name = name
        
        super.init()
    }
}