//
//  EventDetailViewController.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 10/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit
import Kingfisher

class EventDetailViewController: UITableViewController {
    
    var event : Event!
    var rowType : [String] = []
    var rowInfo : [String] = []
    var rowInfoDetail : [String] = []
    var i = 0
    
    @IBOutlet weak var eventImageView : UIImageView!
    @IBOutlet weak var attenEventButton : UIButton!
    @IBOutlet weak var backButton : UIButton!

    override func prefersStatusBarHidden() -> Bool {
       return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        eventImageView.kf_setImageWithURL(NSURL(string: event.imageRemoteUrl!)!, placeholderImage: UIImage(named: "pholder"))
        setupRowsForTableView()
        
        if let image = event.imageOfEvent {
            tableView.backgroundColor = UIColor(patternImage: image)
        }
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        tableView.backgroundView = blurView
        attenEventButton.layer.borderColor = UIColor.whiteColor().CGColor
        attenEventButton.layer.borderWidth = 1.0
        attenEventButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        
        
        
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        //set table view auto height
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //tableviewedgeinsets
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        //hiding navigation bar
        self.navigationController?.navigationBar.hidden = true
        
        
        
        
        //hiding the tab bar
        self.tabBarController?.tabBar.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         print(rowType.count)
         return rowType.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let eventType = rowType[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(eventType, forIndexPath: indexPath)
        
        switch eventType {
        case "Type1" : let label = cell.viewWithTag(100) as! UILabel
                        label.text = event.name
                        label.textColor = UIColor.whiteColor()
            
        case "Type2" : let heading = cell.viewWithTag(100) as! UILabel
                        heading.text = rowInfo[indexPath.row]
                        heading.textColor = UIColor.whiteColor()
                        let detail = cell.viewWithTag(101) as! UILabel
                        detail.text = rowInfoDetail[indexPath.row]
                        detail.textColor = UIColor.whiteColor()
            
        case "Type3" : let heading = cell.viewWithTag(100) as! UILabel
                        heading.text = rowInfo[indexPath.row]
                        heading.textColor = UIColor.whiteColor()
                        (cell.viewWithTag(101) as! UILabel).text = event.contacts[0][0]
                        (cell.viewWithTag(101) as! UILabel).textColor = UIColor.whiteColor()
                        (cell.viewWithTag(102) as! UILabel).text = event.contacts[0][1]
                        (cell.viewWithTag(102) as! UILabel).textColor = UIColor.whiteColor()
                        (cell.viewWithTag(103) as! UILabel).text = event.contacts[1][0]
                        (cell.viewWithTag(103) as! UILabel).textColor = UIColor.whiteColor()
                        (cell.viewWithTag(104) as! UILabel).text = event.contacts[1][1]
                        (cell.viewWithTag(104) as! UILabel).textColor = UIColor.whiteColor()
        default : print("no match of cells")
        }

        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func setupRowsForTableView()
    {
        if let name = event.name {
            rowType.append("Type1")
            rowInfo.append("")
            rowInfoDetail.append("")
            i++
        }
        if event.clubName != nil {
            rowType.append("Type2")
            rowInfo.append("Organized By")
            rowInfoDetail.append(event.clubName!)
            i++
        }
        if event.timeanddate != nil {
            rowType.append("Type2")
            rowInfo.append("Time and date")
            rowInfoDetail.append(String(event.timeanddate!))
            i++
        }
        if event.venue != nil {
            rowType.append("Type2")
            rowInfo.append("Venue")
            rowInfoDetail.append(event.venue)
            
        }
        if event.aboutEvent != nil {
            rowType.append("Type2")
            rowInfo.append("About Event")
            rowInfoDetail.append(event.aboutEvent!)
        }
        if event.contacts.count != 0 {
            rowType.append("Type3")
            rowInfo.append("Contact Details")
            rowInfoDetail.append("")
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
