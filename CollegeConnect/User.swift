//
//  User.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 06/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation

struct User {
    var isLoggedIn : Bool?
    var userName : String!
    var password : String!
    var rollNo : String?
    var collegeName : String?
    var hostelName : String?
    var currentToken : String?
    var signedUpUsingApp : Bool?
    var isAdminOfAClub : Bool?
    var clubIdsOfWhichUserIsAdmin : [Int] = []
    
    init(userName : String, password : String)
    {
        self.userName = userName
        self.password = password
    }
}
