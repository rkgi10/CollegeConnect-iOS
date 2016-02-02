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
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        
        sizeThatFits.height = 40
        return sizeThatFits
    }
    
}
