//
//  TwitterClient.swift
//  Twitter
//
//  Created by Sam Sweeney on 9/29/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    static let credentials = Credentials.defaultCredentials
    static let sharedInstance = TwitterClient(baseURL: twitterBaseURL, consumerKey: credentials.consumerKey, consumerSecret: credentials.consumerSecret)

}
