//
//  Credentials.swift
//  Twitter
//
//  Created by Sam Sweeney on 9/29/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import Foundation

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
