//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Sam Sweeney on 10/4/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            print(tweet)
            profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
            nameLabel.text = tweet.user!.name
            screenNameLabel.text = "@\(tweet.user!.screenname!)"
            tweetTextLabel.text = tweet.text
            createdAtLabel.text = tweet.createdAtString
            numRetweetsLabel.text = "\(tweet.numRetweets!)"
            numFavoritesLabel.text = "\(tweet.numFavorites!)"
            favoriteButton.setImage(UIImage(named: tweet.favorited! ? "favorite_on" : "favorite"), forState: UIControlState.Normal)
            retweetButton.setImage(UIImage(named: tweet.retweeted! ? "retweet_on" : "retweet"), forState: UIControlState.Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReplyButton(sender: AnyObject) {
        print("replied")
    }

    @IBAction func onRetweetButton(sender: AnyObject) {
        print("retweeted")
    }
    
    @IBAction func onFavoriteButton(sender: AnyObject) {
        print("favorited")
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
