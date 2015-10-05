//
//  User.swift
//  Twitter
//
//  Created by Sam Sweeney on 10/3/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "currentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dict: NSDictionary) {
        self.dictionary = dict
        name = dict["name"] as? String
        screenname = dict["screen_name"] as? String
        let normalImageUrl = dict["profile_image_url_https"] as? String
        profileImageUrl = normalImageUrl?.stringByReplacingOccurrencesOfString("normal", withString: "bigger")
        tagline = dict["description"] as? String
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }

    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.init(rawValue: 0)) as! NSDictionary
                        _currentUser = User(dict: dictionary)
                    } catch {
                        print("error grabbing currentUser from dictionary")
                    }
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            var data: NSData?
            if _currentUser != nil {
                do {
                    data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions.init(rawValue: 0))
                } catch {
                    print("error saving currentUser for user: \(user)")
                    data = nil
                }
            } else {
                data = nil
            }
            
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
