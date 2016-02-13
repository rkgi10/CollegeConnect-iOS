//
//  NoImageTabbar.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 29/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import UIKit

class NoImageTabbar : UITabBar {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 40
        
        return sizeThatFits
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor(), NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 16.0)!], forState: .Selected)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(white: 0.5, alpha: 1.0), NSFontAttributeName : UIFont(name: "AvenirNext-Medium", size: 14.0)!], forState: .Normal)
    }
    
}
