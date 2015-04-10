//
//  FAQDetailViewController.swift
//  FAQ
//
//  Created by Michael Reining on 4/10/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class FAQDetailViewController: UIViewController {
    var urlSlug: String!
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        // Loading a URL via a web view
        let fullURL = "http://www.bitsboard.com/" + urlSlug
        let url = NSURL(string: fullURL)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
        println(fullURL)
    }
}
