//
//  EventHomeCell.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 30/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import UIKit

class EventHomeCell : UITableViewCell {
    
    
    @IBOutlet weak var clubNameLabel : UILabel!
    @IBOutlet weak var eventNameLabel : UILabel!
    @IBOutlet weak var eventTimeLabel : UILabel!
    @IBOutlet weak var eventVenueLabel : UILabel!
    @IBOutlet weak var eventImageView : UIImageView!
    @IBOutlet weak var viewBehindClubName: UIView!
    @IBOutlet weak var bottomView: UIView!
    
   // @IBOutlet weak var clubNameBackgroundView : UIView!
    //@IBOutlet weak var likeEventButton : UIButton!
    
    var event : Event! {
        didSet {
            self.clubNameLabel.text = event.clubName
            self.eventNameLabel.text = event.name
            self.eventTimeLabel.text = event.startDate
            self.eventVenueLabel.text = event.venue
            self.eventImageView.image = event.imageOfEvent
            
            self.eventImageView.contentMode = .ScaleAspectFill
            
           // clubNameBackgroundView.backgroundColor = UIColor.orangeColor()
          //  clubNameBackgroundView.frame.size.width = clubNameLabel.frame.width + 5.0
          //  clubNameBackgroundView.frame.size.height = clubNameLabel.frame.height + 4.0
            
            eventImageView.alpha = 1.0
            
            
            
            
            
            
        }
    }
    
   // var event
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}