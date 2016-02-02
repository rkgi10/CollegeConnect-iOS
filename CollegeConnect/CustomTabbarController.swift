//
//  CustomTabbarController.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 29/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit

class CustomTabbarController: UIViewController {
    
    var currentViewContoller : UIViewController?
    @IBOutlet var placeholderView : UIView!
    @IBOutlet var tabButtons : [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tabButtons.count > 0
        {
            performSegueWithIdentifier("EventsButtonTappedSegue", sender: tabButtons[0])
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let availableIdentifiers = ["EventsButtonTappedSegue"]
        
        if availableIdentifiers.contains(segue.identifier!)
        {
            for btn in tabButtons {
                btn.selected = false
            }
            
            let btn = sender as! UIButton
            btn.selected = true
        }
        
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
