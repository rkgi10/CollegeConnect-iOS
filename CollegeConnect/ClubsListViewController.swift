//
//  ClubsListViewController.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 14/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit
import Kingfisher

protocol ClubsListViewControllerDelegate : class {
    func clubsListViewControllerUpdateAfterRelaoding(controller : ClubsListViewController)
}

class ClubsListViewController: UITableViewController {
    
    let data = DataModel.sharedInstance
    let network = NetworkingHelper.sharedInstance
    var nothingFound : Bool = true
    var cellId = "ClubNothingFoundCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // hiding extra cells after the end
        tableView.tableFooterView = UIView(frame: CGRect.zero)
            self.loadClubsInBackground()
        
        self.title = "CLUBS"
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.clubs.count == 0 {
            nothingFound = true
            cellId = "ClubNothingFoundCell"
            return 1
        }
        else
        {
            nothingFound = false
            cellId = "ClubCell"
            return data.clubs.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        if nothingFound {
            
        }
        else
        {
            let club = data.clubs[indexPath.row]
            let clubImage = cell.viewWithTag(100) as! UIImageView
            
            //if let imurl = club.imageRemoteUrl {
                clubImage.kf_setImageWithURL(NSURL(string: club.imageRemoteUrl!)!, placeholderImage: UIImage(named: "pholder"))
//            }
//            else
//            {
//               clubImage.image = UIImage(named: "pholder")
//            }
            
            let clubName = cell.viewWithTag(101) as! UILabel
            clubName.text = data.clubs[indexPath.row].name
            clubName.textColor = UIColor.blackColor()
        }
        


        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if nothingFound {
            
        }
        else
        {
            
        }
    }
    
    func showErrorWithMessage() {
        
    }
    
    func reloadTableViewWithUpdatedData() {
        tableView.reloadData()
    }
    
    func loadClubsInBackground() {
    
            self.network.loadClubsInfo{
                message in
                if message == "Success" {
                    self.reloadTableViewWithUpdatedData()
                }
                else
                {
                    self.showErrorWithMessage()
                }
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
