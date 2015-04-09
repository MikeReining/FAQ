//
//  ViewController.swift
//  FAQ
//
//  Created by Michael Reining on 4/9/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class FAQTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var questions = [FAQ]()
    
    var filteredSearchResults = [FAQ]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questions = [
            FAQ(title: "Q1", url: "www.bitsboard.com/FAQ/q1"),
            FAQ(title: "Q2", url: "www.bitsboard.com/FAQ/q2")
        ]
        
        self.tableView.reloadData()
        
        searchBar.delegate = self
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredSearchResults.count
        } else {
            return self.questions.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        var question: FAQ
        
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            question = filteredSearchResults[indexPath.row]
        } else {
            question = questions[indexPath.row]
        }
        
        cell!.textLabel?.text = question.title
        //        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell!
    }
    
    func filterContentForSearchText(searchText: String) {
        self.filteredSearchResults = self.questions.filter({( question : FAQ) -> Bool in
            
            var stringMatch = question.title.rangeOfString(searchText)
            var searchResults = question.title.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            
            return (searchResults != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.searchDisplayController!.searchBar.showsScopeBar = false
        
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!,
        shouldReloadTableForSearchScope searchOption: Int) -> Bool {
            self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
            return false
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = tableView.indexPathForCell(sender as UITableViewCell)!
        
        let question = questions[indexPath.row]
        
        let nvc = segue.destinationViewController as FAQDetailedViewController
        nvc.title = question.title
        nvc.url = question.url
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        var searchText = searchBar.text
        println(searchText)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        var searchText = searchBar.text
        println(searchText)
    }
    
}


