//
//  AppDelegate.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 26/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataModel = DataModel.sharedInstance
    var networkingHelper = NetworkingHelper.sharedInstance
    var isUpdatingEvents = true


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //call this to decide which screen should be the initial view controller
        whichScreenWillBeFirstScreen()
        
        //load events in background
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)){
            [unowned self] in
            self.networkingHelper.loadEventListInBackground{
                message in
                
                if message == "Success" {
                    NSNotificationCenter.defaultCenter().postNotificationName("EventsDownloadedNotification", object: nil)
                }
                else
                {
                    NSNotificationCenter.defaultCenter().postNotificationName("EventsDownloadFailedNotification", object: nil)
                }
                
                
                
            }
            }
        
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        dataModel.saveData()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        dataModel.saveData()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func checkUserExistsAndLoggedIn() -> (Bool,Bool){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let savedUser = defaults.objectForKey("User") as? NSData
        if savedUser == nil {
            debugPrint("user not found")
            return (false , false)
        }
        else {
            let user = NSKeyedUnarchiver.unarchiveObjectWithData(savedUser!) as! User
                if user.isLoggedIn == true && user.isLoggedIn != nil {
                    debugPrint("user found and logged in")
                    return (true, true)
                }
                else
                {
                    debugPrint("user found but not logged in")
                    return (true, false)
                }
            }
    }
    
    func whichScreenWillBeFirstScreen()
    {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let doesUserExistAndIsLoggedIn = checkUserExistsAndLoggedIn()
        
        if !(doesUserExistAndIsLoggedIn.0) {
            let firstScreenController = mainStoryboard.instantiateViewControllerWithIdentifier("FirstScreen") as? FirstViewController
            self.window?.rootViewController = firstScreenController
            self.window?.makeKeyAndVisible()
            
        }
        else {
            
            if doesUserExistAndIsLoggedIn.1 {
                let homeScreenController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeScreen") as? UITabBarController
                self.window?.rootViewController = homeScreenController
                self.window?.makeKeyAndVisible()
                
            }
            else {
                let firstScreenController = mainStoryboard.instantiateViewControllerWithIdentifier("FirstScreen") as? FirstViewController
                self.window?.rootViewController = firstScreenController
                self.window?.makeKeyAndVisible()
                registerPermissionForLocalNotifications()
                
            }
        }

    }
    
    func registerPermissionForLocalNotifications()
    {
        let notificationSettings = UIUserNotificationSettings(
            forTypes: [.Alert, .Sound, .Badge], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings( notificationSettings)
    }


}

