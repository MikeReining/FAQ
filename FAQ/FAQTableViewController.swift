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
    
    var searchResults = [FAQ]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        // Sample Data for candyArray
        self.questions = [
            FAQ(question: "Q1", url: "http://www.google.com"),
            FAQ(question: "Q2", url: "http://www.bitsboard.com")
        ]
        
        // Reload the table
        self.tableView.reloadData()
        
        searchBar.delegate = self
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.searchResults.count
        } else {
            return self.questions.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        var candy : FAQ
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            candy = searchResults[indexPath.row]
        } else {
            candy = questions[indexPath.row]
        }
        
        // Configure the cell
        cell.textLabel!.text = candy.question
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func filterContentForSearchText(searchText: String) {
        self.searchResults = self.questions.filter({( candy : FAQ) -> Bool in
            
            var stringMatch = candy.question.rangeOfString(searchText)
            var searchResults = candy.question.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showAnswer", sender: tableView)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        var searchText = searchBar.text
        println(searchText)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showAnswer" {
            let nvc = segue.destinationViewController as FAQDetailViewController
            if sender as UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                let selectedQuestion = self.searchResults[indexPath.row]
                nvc.title = selectedQuestion.question
                nvc.urlString = selectedQuestion.url
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow()!
                let selectedQuestion = self.questions[indexPath.row]
                nvc.title = selectedQuestion.question
                nvc.urlString = selectedQuestion.url
            }
        }
    }
}
