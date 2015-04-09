// Playground - noun: a place where people can play

import UIKit


var Section1 = [
    ["question": "Q1","url": "www.bitsboard.com/FAQ/q1"],
    ["question": "Q2","url": "www.bitsboard.com/FAQ/q2"],
]

var Section2 = [
    ["question": "Q3","url": "www.bitsboard.com/FAQ/q3"],
    ["question": "Q4","url": "www.bitsboard.com/FAQ/q4"],
]

var myArray = [Section1,Section2]

let array = [[Dictionary<String, String>]]()

Section1.count

var question = Section1[0]
question["question"]
question["url"]

enum Section: Int {
    case One = 1
    case Two, Three
    func simpleDescription() -> String {
        switch self {
        case .One:
            return "Common Questions"
        case .Two:
            return "Getting Started"
        case .Three:
            return "Other"
        default:
            return String(self.rawValue)
            
        }
    }
}

var test = Section.One.rawValue


struct Question {
    let section : Section
    let title : String
    let url: String
}

var questions = [
    Question(section: Section.One, title: "Q1", url: "www.1"),
    Question(section: Section.One, title: "Q2", url: "www.2"),
    Question(section: Section.Two, title: "Q3", url: "www.3")
]

questions.count

let filteredResults = questions.filter({ $0.section.rawValue == 1})

filteredResults.count

filteredResults[0].title

var sectionOne = Section.One.rawValue

var searchResults = [Question]()

func filterContentForSearchText(searchText: String) {
    // Filter the array using the filter method
    searchResults = questions.filter({( question: Question) -> Bool in
        let stringMatch = question.title.rangeOfString(searchText)
        return (stringMatch != nil)
    })
}

filterContentForSearchText("Q1")

searchResults

