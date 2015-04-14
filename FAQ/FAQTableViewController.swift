//
//  ViewController.swift
//  FAQ
//
//  Created by Michael Reining on 4/9/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit
import Parse

class FAQTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var questions = [FAQ]()
    
    var searchResults = [FAQ](){
        didSet  {self.tableView.reloadData()}
    }
    var searchQuery: String?
    
    var searchController = UISearchController()

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        // FAQ data... can later move this out into a PLIST file
        self.questions = [
            
            // Getting Started
            FAQ(label: "Getting Started", type: "User Guide", urlSlug: "getting-started/1-introduction"),
            


            // User Guides
            FAQ(label: "Bitsboard Classes", type: "User Guide", urlSlug: "bitsboard-classes"),
            FAQ(label: "Accessibility", type: "User Guide", urlSlug: "accessibility"),
            FAQ(label: "Bitsboard Catalog", type: "User Guide", urlSlug: "guides/bitsboard-catalog"),
            FAQ(label: "How to create and edit a board?", type: "User Guide", urlSlug: "how-do-i-create-and-edit-a-board"),
            FAQ(label: "Manage Users", type: "User Guide", urlSlug: "guides/manage-users"),
            FAQ(label: "Track Users", type: "User Guide", urlSlug: "guides/track-users"),
            FAQ(label: "Bitsboard for Preschoolsers", type: "User Guides", urlSlug: "bitsboard-for-preschoolers"),

            
            // Games
            FAQ(label: "Flashcards", type: "Game Settings", urlSlug: "games/flashcards"),
            FAQ(label: "Explore", type: "Game Settings", urlSlug: "games/explore"),
            FAQ(label: "Photo Touch", type: "Game Settings", urlSlug: "games/photo-touch"),
            FAQ(label: "True or False", type: "Game Settings", urlSlug: "games/true-or-false"),
            FAQ(label: "Genius", type: "Game Settings", urlSlug: "games/genius"),
            FAQ(label: "Memory Cards", type: "Game Settings", urlSlug: "games/memory-cards"),
            FAQ(label: "Pop Quiz", type: "Game Settings", urlSlug: "games/pop-quiz"),
            FAQ(label: "Match Up", type: "Game Settings", urlSlug: "games/match-up"),
            FAQ(label: "Word Builder", type: "Game Settings", urlSlug: "games/word-builder"),
            FAQ(label: "Word Search", type: "Game Settings", urlSlug: "games/word-search"),
            FAQ(label: "Spelling Bee", type: "Game Settings", urlSlug: "games/spelling-bee"),
            FAQ(label: "Bingo", type: "Game Settings", urlSlug: "games/bingo"),
            FAQ(label: "Reader", type: "Game Settings", urlSlug: "games/reader"),
            FAQ(label: "Photo Hunt", type: "Game Settings", urlSlug: "games/photo-hunt"),
            FAQ(label: "Story Time", type: "Game Settings", urlSlug: "games/story-time"),
            FAQ(label: "Side by Side", type: "Game Settings", urlSlug: "games/side-by-side"),
            FAQ(label: "Odd One Out", type: "Game Settings", urlSlug: "games/odd-one-out"),
            FAQ(label: "Sort It", type: "Game Settings", urlSlug: "games/sort-it"),
            FAQ(label: "Unscramble", type: "Game Settings", urlSlug: "games/unscramble"),
            FAQ(label: "Puzzles", type: "Game Settings", urlSlug: "games/puzzles"),
            FAQ(label: "Review Game", type: "Game Settings", urlSlug: "games/review-game"),
            FAQ(label: "Trace It", type: "Game Settings", urlSlug: "games/trace-it"),
            FAQ(label: "Missing Letter", type: "Game Settings", urlSlug: "games/missing-letter"),
            FAQ(label: "Sequences", type: "Game Settings", urlSlug: "games/sequences"),
            
            
            // Common Questions
            FAQ(label: "How do I delete boards from the catalog?", type: nil, urlSlug: "faq/how-do-i-delete-boards-from-the-catalog"),
            FAQ(label: "How do I delete a user?", type: nil, urlSlug: "how-do-i-delete-a-user"),
            FAQ(label: "How do I change the username?", type: nil, urlSlug: "faq/how-do-i-change-the-username"),
            FAQ(label: "How can I arrange and sort my cards within a board?", type: nil, urlSlug: "how-can-i-arrange-and-sort-my-cards-within-a-board"),
            FAQ(label: "How can I change the board thumbnail / cover image?", type: nil, urlSlug: "how-can-i-change-the-board-thumbnail"),
            FAQ(label: "No Sound?", type: nil, urlSlug: "no-sound"),
            FAQ(label: "Create and import boards from computer with Dropbox", type: nil, urlSlug: "create-and-import-boards-from-computer-with-dropbox"),
            FAQ(label: "Backup your boards with Dropbox", type: nil, urlSlug: "backup-your-boards-with-dropbox"),
            FAQ(label: "What does sharing boards really mean?", type: nil, urlSlug: "/sharing-boards"),
            FAQ(label: "What's the difference between the FREE and PRO app?", type: nil, urlSlug: "pro-vs-free"),
            FAQ(label: "What's the difference between each in-app-purchase?", type: nil, urlSlug: "in-app-purchases"),
        
        ]
        
        // Reload the table
        self.tableView.reloadData()
        
        //searchBar.delegate = self
        
        // Configure countrySearchController
        self.searchController = ({
            // Two setups provided below:
            
            // Setup One: This setup present the results in the current view.
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            /*
            // Setup Two: Alternative - This presents the results in a sepearate tableView
            let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let alternateController:AlternateTableViewController = storyBoard.instantiateViewControllerWithIdentifier("aTV") as! AlternateTableViewController
            let controller = UISearchController(searchResultsController: alternateController)
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchResultsUpdater = alternateController
            controller.definesPresentationContext = false
            controller.searchBar.sizeToFit()
            self.countryTable.tableHeaderView = controller.searchBar
            */
            return controller
        })()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return self.searchResults.count
        } else {
            return self.questions.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        var answer: FAQ
        if (self.searchController.active) && searchController.searchBar.text != ""
        {
            answer = self.searchResults[indexPath.row]
        }
            
        else
        {
            answer = self.questions[indexPath.row]
       }
        cell.textLabel?.text! = answer.label
        if answer.type != nil {
            cell.detailTextLabel?.text! = answer.type!
        }
        return cell

    }
    
    func filterContentForSearchText(searchText: String) {
        self.searchResults = self.questions.filter({( question : FAQ) -> Bool in
            
            var stringMatch = question.label.rangeOfString(searchText)
            var searchResults = question.label.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            
            return (searchResults != nil)
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.searchResults.removeAll(keepCapacity: false)
        
        let searchText = searchController.searchBar.text
        let results = filter(questions) { $0.label.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil }
        
        println("found \(results.count) result with: \(searchText)");
        for result in results {
            self.searchResults.append(result)
            println(result.label);
        }
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
        search.saveInBackgroundWithBlock { (success, error) -> Void in
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
            search.saveInBackgroundWithBlock { (success, error) -> Void in
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
            search.saveInBackgroundWithBlock { (success, error) -> Void in
                println("Object has been saved.")
            }
        }
    }
    
    
    
    
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showAnswer" {
            let nvc = segue.destinationViewController as! FAQDetailViewController
            if searchController.active {
                let indexPath = self.tableView.indexPathForSelectedRow()!
                let selectedQuestion = self.searchResults[indexPath.row]
                nvc.question = selectedQuestion
                nvc.title = selectedQuestion.label
                
                // send selected Answer to Parse
                    
                let search = PFObject(className: "FAQAnswers")
                search["answer"] = selectedQuestion.label
                search["type"] = "search"
                search.saveInBackgroundWithBlock { (success, error) -> Void in
                    println("Object has been saved.")
                }
                
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow()!
                let selectedQuestion = self.questions[indexPath.row]
                nvc.question = selectedQuestion
                nvc.title = selectedQuestion.label

                // send selected Answer to Parse
                
                let search = PFObject(className: "FAQAnswers")
                search["answer"] = selectedQuestion.label
                search["type"] = "main"
                search.saveInBackgroundWithBlock { (success, error) -> Void in
                    println("Object has been saved.")
                }
            }
        }
    }
}
