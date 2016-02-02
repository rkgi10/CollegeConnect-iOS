//
//  ViewController.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 26/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: UIViewController {
    
    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var guestLoginButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsSetup()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonsSetup()
    {
        
        signUpButton.layer.borderWidth = 0.5
        signUpButton.layer.borderColor = UIColor.grayColor().CGColor
        signInButton.layer.borderWidth = 0.0
        signInButton.layer.borderColor = UIColor.grayColor().CGColor
        guestLoginButton.layer.borderWidth = 0.5
        guestLoginButton.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func performRequest()
    {
        let postEndpoint : String = "https://sheltered-fjord-8731.herokuapp.com/api/user/reg"
        
        guard let url = NSURL(string: postEndpoint) else {
            print("Error can't create URL")
            return
        }
        
        let postUrlRequest = NSMutableURLRequest(URL: url)
        postUrlRequest.HTTPMethod = "POST"
        
        postUrlRequest.addValue("rkgi10@gmail.com", forHTTPHeaderField: "authorization")
        postUrlRequest.addValue("12345678", forHTTPHeaderField: "password")
        
        let newPost : NSDictionary = ["name" : "RKG", "rollno" : "u13co200", "mobno" : "9510000000", "email" : "rkgi10@googlemail.com"]
        do {
            let jsonPost = try NSJSONSerialization.dataWithJSONObject(newPost, options: [])
            postUrlRequest.HTTPBody = jsonPost
        }
        catch{
            print("Error can't create json object")
        }
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(postUrlRequest, completionHandler: {
            data, response, error in
            
            guard let responseData = data else {
                print("Didn't recieve data")
                return
            }
            
            guard error == nil else {
                print("Error in request")
                print(error)
                return
            }
            
            if let post = String(data: responseData, encoding: NSUTF8StringEncoding) {
                print(post)
            }
            print("Response \n \(response!)")
            
        })
        task.resume()
        
    }
    


}

