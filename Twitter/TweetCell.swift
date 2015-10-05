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
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onReplyButton(sender: AnyObject) {
        delegate.tweetCell(self, id: tweet.id!, username: tweet.user!.screenname!)
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
