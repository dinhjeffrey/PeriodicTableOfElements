//
//  AboutVIewController.swift
//  TableOfElements
//
//  Created by Lance Matysik on 3/2/16.
//  Copyright © 2016 Lance Matysik. All rights reserved.
//

import UIKit
import Social


class AboutViewController: UIViewController {
    
    @IBAction func twitterButton(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetShare.setInitialText("@lancematysik I used your Table of Elements app for fun and mostly profit!")
            tweetShare.addURL(NSURL(string: "https://goo.gl/qWe1ii"))
            self.presentViewController(tweetShare, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
}