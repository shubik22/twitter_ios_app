//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Sam Sweeney on 10/4/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate, TweetCellDelegate {

    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    var inReplyToStatusId: Int?
    var inReplyToUsername: String?
    var selectedTweet: Tweet?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.333, green: 0.675, blue: 0.933, alpha: 1.0)

        if self.navigationController == nil {
            addNavBar()
        }

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        loadTimeline()
    }
    
    func onRefresh() {
        loadTimeline()
        refreshControl.endRefreshing()
    }

    func loadTimeline() {
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
        cell.delegate = self
        
        return cell
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTweet = tweets![indexPath.row]
        self.performSegueWithIdentifier("detailsSegue", sender: self)
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
        
        let rightButton =  UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "onNewTweet")
        rightButton.tintColor = UIColor.whiteColor()
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        navigationBar.items = [navigationItem]
        
        self.view.addSubview(navigationBar)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController

        if segue.identifier == "compositionSegue" {
            let compositionViewController = navigationController.topViewController as! CompositionViewController
            compositionViewController.inReplyToStatusId = inReplyToStatusId
            compositionViewController.inReplyToUsername = inReplyToUsername
            
            self.inReplyToStatusId = nil
            self.inReplyToUsername = nil
        } else if segue.identifier == "detailsSegue" {
            let detailsViewController = navigationController.topViewController as! TweetDetailsViewController
            detailsViewController.tweet = self.selectedTweet!
            self.selectedTweet = nil
        }
    }
    
    func tweetCell(tweetCell: TweetCell, id: Int, username: String) {
        inReplyToStatusId = id
        inReplyToUsername = username
        self.performSegueWithIdentifier("compositionSegue", sender: self)
    }
    
    func onLogout() {
        User.currentUser?.logout()
    }
    
    func onNewTweet() {
        self.performSegueWithIdentifier("compositionSegue", sender: self)
    }

}
