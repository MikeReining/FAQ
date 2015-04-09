//
//  ViewController.swift
//  FAQ
//
//  Created by Michael Reining on 4/9/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

    var sectionHeaders = [FAQSection.One.simpleDescription(), FAQSection.Two.simpleDescription()]
    @IBOutlet weak var searchBar: UISearchBar!
    
    var questions = [FAQ]()
    
    
    var filteredSearchResults = [String]()
    
    var searchActive : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        


        self.questions = [
            FAQ(section: FAQSection.One, title: "Q1", url: "www.bitsboard.com/FAQ/q1"),
            FAQ(section: FAQSection.Two, title: "Q2", url: "www.bitsboard.com/FAQ/q2")
        ]

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredResults = questions.filter({ $0.section.rawValue == section + 1})
        filteredResults.count
        println(filteredResults.count)
        return filteredResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        let filteredResults = questions.filter({ $0.section.rawValue == indexPath.section + 1})
        let question = filteredResults[indexPath.row]
        let questionString = question.title
        
        cell!.textLabel?.text = questionString
        return cell!
    }
    
    // section headers
    
    override func tableView(tableView: UITableView,titleForHeaderInSection section: Int)
        -> String {
            
            
                return sectionHeaders[section]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = tableView.indexPathForCell(sender as UITableViewCell)!
        let filteredResults = questions.filter({ $0.section.rawValue == indexPath.section + 1})

        let question = filteredResults[indexPath.row]
        let questionURL = question.url
        
        let nvc = segue.destinationViewController as FAQDetailedViewController
        nvc.url = questionURL
    }
    
    // Search
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
}
    

