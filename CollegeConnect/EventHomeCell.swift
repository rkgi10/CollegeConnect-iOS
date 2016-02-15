//
//  EventHomeCell.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 30/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

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
            
            //downloading and caching the image with kingfisher.Yay!
            self.eventImageView.kf_setImageWithURL(NSURL(string: event.imageRemoteUrl!)!, placeholderImage: UIImage(named: "pholder"))
            
            self.eventImageView.contentMode = .ScaleAspectFill
            
            
            eventImageView.alpha = 1.0
            
            
            
            
        }
    }
    
   // var event
    override func layoutSubviews() {
        self.bottomView.layer.borderWidth = 1.0
        self.bottomView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        self.bottomView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}