//
//  CustomTabbarViewController.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 14/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit

class CustomTabbarViewController: UITabBarController {

    override func viewWillAppear(animated: Bool) {
        self.insertEmptyTabItem("", atIndex: 2)
        self.addRaisedButton(34.0, width: 34.0, color: UIColor.blackColor(), text: "+")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: getting an empty spot for our circular button
    func insertEmptyTabItem(title: String, atIndex: Int) {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: title, image: nil, tag: 0)
        vc.tabBarItem.enabled = false
        
        self.viewControllers?.insert(vc, atIndex: atIndex)
    }
    
    //MARK: constructing the circular button
    func addRaisedButton(height : CGFloat , width : CGFloat, color : UIColor?, text : String){
        
        let button = UIButton(type: .Custom)
        button.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleRightMargin]
        
        button.frame = CGRectMake(0.0, 0.0, width, height)
        button.backgroundColor = color!
        button.setTitle(text, forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 36)
        
        button.layer.cornerRadius = width/2.0
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 0.5
        
        
        let heigthDiff = button.frame.size.height - self.tabBar.frame.size.height
        
        if (heigthDiff < 0) {
            //button is smaller than tabbar, then both their centers should match
            button.center = self.tabBar.center
        }
        else
        {
            var center = self.tabBar.center
            center.y -= heigthDiff/2.0
            
            button.center = center
        }
        
        button.addTarget(self, action: "onRaisedButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    
    func onRaisedButton(sender: UIButton!) {
        print("raised button tapped")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
