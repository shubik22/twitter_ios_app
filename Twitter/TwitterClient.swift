//
//  TwitterClient.swift
//  Twitter
//
//  Created by Sam Sweeney on 9/29/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

let twitterConsumerKey = ""
let twitterConsumerSecret = ""
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {

    
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
