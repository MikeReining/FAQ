//
//  FAQDetailViewController.swift
//  FAQ
//
//  Created by Michael Reining on 4/10/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit
import Parse

class FAQDetailViewController: UIViewController {
    var question: FAQ!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var helpful: UIBarButtonItem!
    
    @IBAction func yesButtonPressed(sender: AnyObject) {
        self.sentYesToParse()
    }
    
    @IBAction func noButtonPressed(sender: AnyObject) {
        self.sentNoToParse()
        
    }
    
    @IBAction func helpfulButtonPressed(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Was the answer helpful?", message: "Please let us know so we can serve you better.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Yes", style: .Cancel) { (action) in
            // send answer to Parse
                self.sentYesToParse()
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "No", style: .Default) { (action) in
            // send answer to Parse
            self.sentNoToParse()
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    
    override func viewDidLoad() {
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        // Loading a URL via a web view
        let fullURL = "http://www.bitsboard.com/" + question.urlSlug
        let url = NSURL(string: fullURL)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
        println(fullURL)
    }
    
    func sentYesToParse() {
        // send answer to Parse
        let feedback = PFObject(className: "Helpful")
        feedback["query"] = self.question.question
        feedback["helpful"] = "Yes"
        feedback.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            println("Object has been saved.")
        }
    }
    
    func sentNoToParse() {
        // send answer to Parse
        let feedback = PFObject(className: "Helpful")
        feedback["query"] = self.question.question
        feedback["helpful"] = "No"
        feedback.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            println("Object has been saved.")
        }
    }
    
}
