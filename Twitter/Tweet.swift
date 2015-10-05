//
//  Tweet.swift
//  Twitter
//
//  Created by Sam Sweeney on 10/3/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: Int?
    var favorited: Bool?
    var retweeted: Bool?
    var numFavorites: Int?
    var numRetweets: Int?
    
    init(dictionary: NSDictionary) {
        user = User(dict: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweeted = dictionary["retweeted"] as? Bool
        numFavorites = dictionary["favorites"] as? Int
        numRetweets = dictionary["retweets"] as? Int

        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
    func favoriteWithCompletion(completion: (success: Bool) -> ()) {
        let params = ["id": id!]
        TwitterClient.sharedInstance.postFavoriteWithParams(params) { (error) -> () in
            completion(success: error == nil)
        }
    }
    
    func retweetWithCompletion(completion: (success: Bool) -> ()) {
        TwitterClient.sharedInstance.retweetTweetWithCompletion(id!) { (error) -> () in
            completion(success: error == nil)
        }
    }
}
