//
//  NetworkingHelper.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 06/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


enum HTTPRequestAuthType {
    case HTTPBasicAuth
    case HTTPTokenAuth
}

enum HTTPRequestContentType {
    case HTTPJsonContent
    case HTTPMultipartContent
}

class NetworkingHelper {
    
    static let sharedInstance = NetworkingHelper()

    init()
    {
        print("network helper initiaised")
    }
    
    let base_url = "https://sheltered-fjord-8731.herokuapp.com/api/"
    let dataHelper = DataHelper.sharedInstance
    
    
    
    //MARK: make a sign in request
    func makeSignInRequest(userName : String, withPassword password : String, completionHandler : (message : String) ->Void) {
        let signInUrl = base_url + "user/token"
        let credentialData = "\(userName):\(password)".toBase64()
        var messageToBeReturned = ""
        
        let headers = ["Authorization" : "Basic \(credentialData)",
                        "Content-Type": "application/x-www-form-urlencoded"
                        ]
        Alamofire.request(.GET, signInUrl, headers : headers).responseJSON{
            response in
           // debugPrint(response.request)
            
            switch response.result {
            case .Success(let value):
                //extract the token and save the user's info to disk
                let json = JSON(value)
                if let token = json["token"].string {
                   messageToBeReturned = self.dataHelper.setUserInDefaults(userName, password: password, withToken: token)
                }
                else
                {
                    debugPrint(response.result.value)
                    messageToBeReturned = JSON(response.result.value!)["message"].stringValue
                   
                    
                }
               // print(token)
            case .Failure(let error):
                debugPrint(error)
                messageToBeReturned = "Failure"
            }
            completionHandler(message: messageToBeReturned)
        }
            
       // return messageToBeReturned
    }
    
    
    //MARK: Make a Sign-UP request
    
    
    
    //MARK: Load events in background
    func loadEventListInBackground()
    {
        print("started bg loading")
        let loadEventsUrl = base_url + "events"
        Alamofire.request(.GET, loadEventsUrl).responseJSON{
            response in
            
            debugPrint(response.result)
           
            switch response.result {
            case .Success(let value) : let json = JSON(value)
            let events = json["events"]
            self.dataHelper.saveEventModel(events)
            
            default : print("bg failure")
                
                
            }
        }
    }
    
    
    
}
