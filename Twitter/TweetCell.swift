//
//  TweetCell.swift
//  Twitter
//
//  Created by Sam Sweeney on 10/4/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate {
    func tweetCell(tweetCell: TweetCell, id: Int, username: String)
}

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var delegate: TweetCellDelegate!

    var tweet: Tweet! {
        didSet {
            profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
            userNameLabel.text = tweet.user!.name
            twitterHandleLabel.text = "@\(tweet.user!.screenname!)"
            tweetTextLabel.text = tweet.text
            timestampLabel.text = formatTimeElapsed(tweet.createdAt!)
            favoriteButton.setImage(UIImage(named: tweet.favorited! ? "favorite_on" : "favorite"), forState: UIControlState.Normal)
            retweetButton.setImage(UIImage(named: tweet.retweeted! ? "retweet_on" : "retweet"), forState: UIControlState.Normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onReplyButton(sender: AnyObject) {
        delegate.tweetCell(self, id: tweet.id!, username: tweet.user!.screenname!)
    }
    
    @IBAction func onRetweetButton(sender: AnyObject) {
        tweet.retweetWithCompletion { (success) -> () in
            if success {
                self.retweetButton.setImage(UIImage(named: "retweet_on"), forState: UIControlState.Normal)
            }
        }
    }

    @IBAction func onFavoriteButton(sender: AnyObject) {
        tweet.favoriteWithCompletion { (success) -> () in
            if success {
                self.favoriteButton.setImage(UIImage(named: "favorite_on"), forState: UIControlState.Normal)
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func formatTimeElapsed(sinceDate: NSDate) -> String {
        let formatter = NSDateComponentsFormatter()
        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Abbreviated
        formatter.collapsesLargestUnit = true
        formatter.maximumUnitCount = 1
        let interval = NSDate().timeIntervalSinceDate(sinceDate)
        return formatter.stringFromTimeInterval(interval)!
    }
    
}
