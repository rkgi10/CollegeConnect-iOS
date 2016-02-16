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
    
    let base_url = "https://college-connect.herokuapp.com/api/"
    let base_url2 = "https://sheltered-fjord-8731.herokuapp.com/api/"
    let dataHelper = DataHelper.sharedInstance
    let data = DataModel.sharedInstance
    
    
    
    //MARK: make a sign in request
    func makeSignInRequest(userName : String, withPassword password : String, completionHandler : (message : String) ->Void) {
        let signInUrl = base_url2 + "user/token"
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
    func makeSignUpRequest(user : User, completionHandler : (message : String)->Void)
    {
        //1 - configuration before making a request
        let signUpUrl = base_url2 + "user/reg"
        let credentialData = "\(user.userName):\(user.password)".toBase64()
        var messageToBeReturned = ""
        
        
        //2 - configuring headers
        let headers = ["Authorization" : "Basic \(credentialData)",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        
        //3 - configuring parameters i.e. body of the request
        let parameters = [
            "name" : user.fullName!,
            "rollno" : user.rollNo!,
            "mobno" : user.mobileNumber!,
            "hostelname" : user.hostelName!,
            "hostel_or_local": String(user.hosteliteOrLocalite)
        ]
        
        
        //4- Actually making the request
        Alamofire.request(.POST, signUpUrl, parameters: parameters, encoding: .JSON, headers: headers).responseJSON{
            response in
            
            switch response.result {
                
            case .Success(let value) : let json = JSON(value)
            
            if let token = json["token"].string {
                
                //check if user is successfully saved or not and then proceed
                messageToBeReturned = self.dataHelper.setUserInDefaults(user, withToken: token)
                
                }
                else {
                
                //request was successful but returned some error message. handle it
                debugPrint(response.result.value)
                messageToBeReturned = JSON(response.result.value!)["message"].stringValue
                
                }
                
                
            case .Failure(let error) : debugPrint(error)
            //request was unsuccessful. either network error or server error
            messageToBeReturned = "Failure"
                
            }
         completionHandler(message: messageToBeReturned)
        }
        
    }
    
    
    //MARK: Load events in background
    func loadEventListInBackground(completionHandler : (message : String)->Void)
    {
        var messageToBeReturned = ""
        print("started bg events loading")
        let loadEventsUrl = base_url2 + "events"
        let credentialData = "\(data.user.userName):\(data.user.password)".toBase64()
        
        let headers = ["Authorization" : "Basic \(credentialData)",
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        Alamofire.request(.GET, loadEventsUrl, parameters: nil, encoding: .JSON, headers: headers).responseJSON{
            response in
            
           // debugPrint(response.result)
           
            switch response.result {
            case .Success(let value) :
                let json = JSON(value)
                let events = json["events"]
                messageToBeReturned = self.dataHelper.saveEventModel(events)
                
            case .Failure(let error) :
                debugPrint(error.code)
                messageToBeReturned = "Failure"
            
            default : print("bg events failure")
                
                
            }
        }
    }
    
    //MARK: load clubs info 
    func loadClubsInfo(completionHandler : (message : String)->Void)
    {
        var messageToBeReturned = ""
        let loadClubsUrl = base_url2 + "clubs/list"
        
        Alamofire.request(.GET, loadClubsUrl).responseJSON{
            response in
            
            
            switch response.result {
                
            case .Success(let value) :
                let json = JSON(value)
                let clubs = json["clubs"]
                messageToBeReturned = self.dataHelper.saveClubsModel(clubs)
                
            case .Failure(let error) : debugPrint(error.code)
                messageToBeReturned = String(error.code)
                
            default : messageToBeReturned = "Failure"
            }
            completionHandler(message: messageToBeReturned)
        }
    }
    
    
    
}
