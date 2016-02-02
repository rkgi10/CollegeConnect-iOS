//
//  CustomTabbarNavigationSegue.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 29/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit

class CustomTabbarNavigationSegue: UIStoryboardSegue {
    
    override func perform() {
        let tabBarController = sourceViewController as! CustomTabbarController
        let destinationVC = destinationViewController as UIViewController
        
        for view in tabBarController.placeholderView.subviews {
            view.removeFromSuperview()
        }
        
        tabBarController.currentViewContoller = destinationVC
        tabBarController.placeholderView.addSubview(destinationVC.view)
        
        tabBarController.placeholderView.sizeToFit()
        
        
    }

}
