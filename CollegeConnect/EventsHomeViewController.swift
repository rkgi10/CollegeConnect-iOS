//
//  EventsHomeViewController.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 28/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit

class EventsHomeViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var events = sampleeventData
    var pageImages : [UIImage] = []
    var pageViews : [UIImageView?] = []
    var pageCount = 0

    @IBOutlet weak var tabbarItem : UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting the appearance of tab bar and items
        setAppearanceForTabbar()
        setImagesForScrollView()
        setViewsInScrollView()
        loadVisiblePages()
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowEventDetail" {
            let vc = segue.destinationViewController as! EventDetailViewController
            vc.event = events[(sender?.row)!]
        }
    }
    

    func setAppearanceForTabbar()
    {
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor(), NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 15.0)!], forState: .Selected)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(white: 0.7, alpha: 1.0), NSFontAttributeName : UIFont(name: "AvenirNext-Medium", size: 14.0)!], forState: .Normal)
    }
    
    func setImagesForScrollView()
    {
        pageImages = [UIImage(named: "scroll1")!,
            UIImage(named: "scroll2")!,
            UIImage(named: "scroll3")!,UIImage(named: "scroll4")!]
        pageCount = pageImages.count
    }
    
    func setViewsInScrollView()
    {
        for _ in 0..<pageCount
        {
            pageViews.append(nil)
        }
        let pageScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pageScrollViewSize.width * CGFloat(pageCount), height: pageScrollViewSize.height)
    }
    
    func loadPage(page : Int){
        if page < 0 || page > pageCount
        {
            return
        }
        
        if let pageView = pageViews[page]
        {
            //the view is already loaded
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFill
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page : Int) {
        if page < 0 || page > pageCount {
            return
        }
        
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func loadVisiblePages(){
        
        //1 first find out which page is visible
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor(((scrollView.contentOffset.x * 2.0) + pageWidth) / (2.0 * pageWidth)))
        print("\((scrollView.contentOffset.x * 2.0) + pageWidth))")
        print("page is \(page)")
        
        //2 deciding which pages to load or purge
        let firstPage = page - 1
        let lastPage = ((page + 1) < pageCount) ? page + 1 : page
        
        //3Purge anything before the first page
        for(var index = 0; index < firstPage; index++) {
            print("purging page \(index)")
            purgePage(index)
        }
        
        //4 Load pages in our range
        for index in firstPage...lastPage {
            print("loading page \(index)")

            loadPage(index)
        }
        
        //5 Purge pages after the last page
        for(var index = lastPage+1; index < pageCount; index++) {
            print("purging page \(index)")

            purgePage(index)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
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

extension EventsHomeViewController : UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EventHomeCell", forIndexPath: indexPath) as! EventHomeCell
        cell.event = events[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("ShowEventDetail", sender: indexPath)
    }
    
}

extension EventsHomeViewController : UITableViewDelegate {
    
    
    }
