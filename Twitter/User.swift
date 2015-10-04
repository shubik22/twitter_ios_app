//
//  User.swift
//  Twitter
//
//  Created by Sam Sweeney on 10/3/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

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
        profileImageUrl = dict["profile_image_url"] as? String
        tagline = dict["description"] as? String
    }
}
