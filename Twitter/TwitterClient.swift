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

    struct Credentials {
        static let defaultCredentialsFile = "Credentials"
        static let defaultCredentials = Credentials.loadFromPropertyList(defaultCredentialsFile)

        let consumerKey: String
        let consumerSecret: String

        private static func loadFromPropertyList(name: String) -> Credentials {
            let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist")!
            let dictionary = NSDictionary(contentsOfFile: path)!
            let consumerKey = dictionary["ConsumerKey"] as! String
            let consumerSecret = dictionary["ConsumerSecret"] as! String

            return Credentials(consumerKey: consumerKey, consumerSecret: consumerSecret)
        }
    }
}
