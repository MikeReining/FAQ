//
//  ViewController.swift
//  FAQ
//
//  Created by Michael Reining on 4/9/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var FAQ = [
        "test",
        "q2"
        
    ]
    
    var Section1 = [
        ["question": "Q1","url": "www.bitsboard.com/FAQ/q1"],
        ["question": "Q2","url": "www.bitsboard.com/FAQ/q2"],
    ]
    
    var Section2 = [
        ["question": "Q3","url": "www.bitsboard.com/FAQ/q3"],
        ["question": "Q4","url": "www.bitsboard.com/FAQ/q4"],
    ]
    
    var FAQArray: [[Dictionary<String, String>]]!

    var sectionHeaders = ["Common Questions", "Getting Started"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FAQArray = [Section1,Section2]


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return FAQArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = FAQArray[section]
        return currentSection.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        let section = FAQArray[indexPath.section]

        let question = section[indexPath.row]
        let questionString = question["question"]
        
        cell!.textLabel?.text = questionString
        return cell!
    }
    
    // section headers
    
    override func tableView(tableView: UITableView,titleForHeaderInSection section: Int)
        -> String {
                return self.sectionHeaders[section] as String
    }
    

    
}
    

