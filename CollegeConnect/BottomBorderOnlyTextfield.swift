//
//  BottomBorderOnlyTextfield.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 12/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import UIKit

class BottomBorderOnlyTextfield : UITextField {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        let border = CALayer()
        border.borderColor = UIColor.blackColor().CGColor
        border.frame = CGRect(x: 0, y: frame.size.height - 1.0, width: frame.size.width, height: frame.size.height)
        border.borderWidth = 2.0
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}