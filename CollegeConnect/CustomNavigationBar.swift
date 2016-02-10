//
//  CustomNavigationBar.swift
//  
//
//  Created by Rohit Gurnani on 29/01/16.
//
//

import Foundation
import UIKit

class CustomNavigationBar: UINavigationBar {
    
//    override func sizeThatFits(size: CGSize) -> CGSize {
//        var sizeThatFits = super.sizeThatFits(size)
//        
//        sizeThatFits.height = 40
//        return sizeThatFits
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINavigationBar.appearance().titleTextAttributes = ([NSForegroundColorAttributeName : UIColor(white: 0.0, alpha: 1.0), NSFontAttributeName : UIFont(name: "AvenirNext-Medium", size: 18.0)!])
    }
    
}
