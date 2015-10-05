//
//  CompositionViewController.swift
//  Twitter
//
//  Created by Sam Sweeney on 10/4/15.
//  Copyright © 2015 Wealthfront. All rights reserved.
//

import UIKit

class CompositionViewController: UIViewController {

    var user: User! {
        didSet {
            profileImageView.setImageWithURL(NSURL(string: user.profileImageUrl!))
            nameLabel.text = user.name
            twitterHandleLabel.text = "@\(user.screenname!)"
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User.currentUser
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
