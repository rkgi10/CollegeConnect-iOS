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

struct NetworkingHelper {
    
    let base_url = "https://sheltered-fjord-8731.herokuapp.com/api/"
    
    
    func makeSignInRequest(userName : String, withPassword password : String) {
        let signInUrl = base_url + "user/token"
        let credentialData = "\(userName):\(password)".toBase64()
        
        let headers = ["Authorization" : "Basic \(credentialData)",
                        "Content-Type": "application/x-www-form-urlencoded"
                        ]
        Alamofire.request(.GET, signInUrl, headers : headers).responseJSON{
            response in
            //debugPrint(response.request)
            //debugPrint(response.data)
            debugPrint(response.result)
        }
            
        
    }
}
