//
//  ViewController.swift
//  FAQ
//
//  Created by Michael Reining on 4/9/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit
import Parse

class FAQTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var questions = [FAQ]()
    
    var searchResults = [FAQ]()
    var searchQuery: String?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        // Sample Data for candyArray
        self.questions = [
            FAQ(question: "How do I create and edit a board?", urlSlug: "faq/how-do-i-create-and-edit-a-board"),
            FAQ(question: "How do I delete boards from the catalog?", urlSlug: "faq/how-do-i-delete-boards-from-the-catalog"),
            FAQ(question: "How do I delete a user?", urlSlug: "how-do-i-delete-a-user"),
            FAQ(question: "How do I change the username?", urlSlug: "faq/how-do-i-change-the-username"),
            FAQ(question: "How can I arrange and sort my bits (flashcards)?", urlSlug: "how-can-i-arrange-and-sort-my-bits-flashcards"),
            FAQ(question: "How can I change the board thumbnail?", urlSlug: "how-can-i-change-the-board-thumbnail")
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
        
        // send query to Parse
        
        let search = PFObject(className: "FAQSearches")
        search["query"] = searchText
        search["type"] = "search"
        search.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            println("Object has been saved.")
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        var searchText = searchBar.text
        
        // send query to Parse
        if searchText != "" {
            let search = PFObject(className: "FAQSearches")
            search["query"] = searchText
            search["type"] = "cancel"
            search.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
                println("Object has been saved.")
            }
        }
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchQuery = searchBar.text
        
        // send query to Parse
        if searchQuery != "" {

            let search = PFObject(className: "FAQSearches")
            search["query"] = searchQuery
            search["type"] = "editing"
            search.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
                println("Object has been saved.")
            }
        }
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showAnswer" {
            let nvc = segue.destinationViewController as FAQDetailViewController
            if sender as UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                let selectedQuestion = self.searchResults[indexPath.row]
                nvc.title = selectedQuestion.question
                nvc.urlSlug = selectedQuestion.urlSlug
                
                // send selected Answer to Parse
                    
                let search = PFObject(className: "FAQAnswers")
                search["answer"] = selectedQuestion.question
                search["type"] = "search"
                search.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
                    println("Object has been saved.")
                }
                
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow()!
                let selectedQuestion = self.questions[indexPath.row]
                nvc.title = selectedQuestion.question
                nvc.urlSlug = selectedQuestion.urlSlug
                
                // send selected Answer to Parse
                
                let search = PFObject(className: "FAQAnswers")
                search["answer"] = selectedQuestion.question
                search["type"] = "main"
                search.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
                    println("Object has been saved.")
                }
            }
        }
    }
}
