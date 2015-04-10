//
//  FAQDetailViewController.swift
//  FAQ
//
//  Created by Michael Reining on 4/10/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class FAQDetailViewController: UIViewController {
    var urlString: String!
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        // Loading a URL via a web view
        let url = NSURL(string: urlString!)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
}
