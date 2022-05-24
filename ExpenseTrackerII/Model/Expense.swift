//
//  Expense.swift
//  ExpenseTrackerII
//
//  Created by Sopnil Sohan on 22/5/22.
//

import Foundation
import SwiftUI

//MARK: Expense Model and sample Data

struct Expense: Identifiable,Hashable {
    var id = UUID().uuidString
    var remark: String
    var amount: Double
    var date: Date
    var type: ExpenseType
    var color: String
}

enum ExpenseType: String {
    case income = "Income"
    case expense = "expense"
    case all = "ALL"
}

var sampleExpense: [Expense] = [
    
    Expense(remark: "Magic Kyboard", amount: 200, date: Date(timeIntervalSince1970: 1652987245), type: .expense, color: "Yellow"),
    Expense(remark: "Food", amount: 19, date: Date(timeIntervalSince1970: 1652814445 ), type: .expense, color: "Red"),
    Expense(remark: "Magic Trackpad", amount: 99, date: Date(timeIntervalSince1970: 1652382445), type: .expense, color: "Green"),
    Expense(remark: "Ubar cab", amount: 20, date: Date(timeIntervalSince1970: 1652296045), type: .expense, color: "Yellow"),
    Expense(remark: "Amazon Purchase", amount: 299, date: Date(timeIntervalSince1970: 1652209645), type: .expense, color: "Purple"),
    Expense(remark: "Strock", amount: 2599, date: Date(timeIntervalSince1970: 1652036845), type: .income, color: "Red"),
    Expense(remark: "In App Purchase", amount: 99, date: Date(timeIntervalSince1970: 1651864045), type: .expense, color: "Yellow"),
    Expense(remark: "Movie Ticket", amount: 25, date: Date(timeIntervalSince1970: 1651691245), type: .expense, color: "Green"),
    Expense(remark: "Apple Music", amount: 49, date: Date(timeIntervalSince1970: 16511518445), type: .expense, color: "Purple"),
    Expense(remark: "Snacks", amount: 49, date: Date(timeIntervalSince1970: 1651432045), type: .expense, color: "Purple"),
]
