//
//  EventModel.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 10/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
class EventDataModel : NSObject {
    
    static let sharedInstance = EventDataModel()
    
    var events : [Event] = []
    
    
}