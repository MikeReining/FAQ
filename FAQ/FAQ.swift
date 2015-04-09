//
//  Questions.swift
//  FAQ
//
//  Created by Michael Reining on 4/9/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import Foundation

struct FAQ {
    let section : FAQSection
    let title : String
    let url: String
}

enum FAQSection: Int {
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