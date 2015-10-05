//
//  CompositionViewController.swift
//  Twitter
//
//  Created by Sam Sweeney on 10/4/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

class CompositionViewController: UIViewController {

    var user: User! {
        didSet {
            profileImageView.setImageWithURL(NSURL(string: user.profileImageUrl!))
            nameLabel.text = user.name
            twitterHandleLabel.text = "@\(user.screenname!)"
        }
    }
    var sendingVC: UIViewController?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User.currentUser

        tweetTextView.layer.borderWidth = 1.0
        tweetTextView.layer.borderColor = UIColor.grayColor().CGColor
        tweetTextView.clipsToBounds = true
        tweetTextView.layer.cornerRadius = 3.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        let params = ["status": tweetTextView.text]
        TwitterClient.sharedInstance.postTweetWithParams(params) { (error) -> () in
            if error != nil {
                print("error posting tweet: \(self.tweetTextView.text)")
                print(error)
            } else {
                self.performSegueWithIdentifier("homeSegue", sender: self)
            }
            
        }
    }

    @IBAction func onCancel(sender: AnyObject) {
        self.performSegueWithIdentifier("homeSegue", sender: self)
    }

}
