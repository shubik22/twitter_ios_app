//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Sam Sweeney on 10/4/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate {

    var tweets: [Tweet]?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.333, green: 0.675, blue: 0.933, alpha: 1.0)
        
        if self.navigationController == nil {
            addNavBar()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    func addNavBar() {
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))

        navigationBar.barTintColor = UIColor(red: 0.333, green: 0.675, blue: 0.933, alpha: 1.0)
        navigationBar.delegate = self
                let navigationItem = UINavigationItem()
        navigationItem.title = "Home"
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        let leftButton =  UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Plain, target: self, action: "onLogout")
        leftButton.tintColor = UIColor.whiteColor()
        
        navigationItem.leftBarButtonItem = leftButton
        navigationBar.items = [navigationItem]
        
        self.view.addSubview(navigationBar)
    }
    
    func onLogout() {
        User.currentUser?.logout()
    }
    

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let vc = segue.destinationViewController as! TweetsViewController
//        if vc.navigationController == nil {
//            vc.addNavBar()
//        }
//    }

}
