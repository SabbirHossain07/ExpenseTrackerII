//
//  ExpenseViewModel.swift
//  ExpenseTrackerII
//
//  Created by Sopnil Sohan on 22/5/22.
//

import Foundation
import SwiftUI

class ExpenseViewModel: ObservableObject {
    //MARK: Properties
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    
    //MARK: Expense / Income Tab
    @Published var tabName: ExpenseType = .expense
    //MARK: Filter View
    @Published var showFilterView: Bool = false
    //MARK: New Expense Properties
    @Published var addNewExpense: Bool = false
    @Published var amount: String = ""
    @Published var type: ExpenseType = .all
    @Published var date: Date = Date()
    @Published var remark: String = ""
    
    
    init() {
        //MARK: Fetching Current Month Starting Date
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month], from: Date())
        
        startDate = calender.date(from: components)!
        currentMonthStartDate = calender.date(from: components)!
    }
    //MARK: This is a Sample Data of month may
    //you can castomize this even more with your Data (core data)
    @Published var expenses: [Expense] = sampleExpense
    
    //MARK: Fetching Current Month Date String
    func currentMonthDateString()->String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertExpensesToCurrency(expenses: [Expense], type: ExpenseType = .all)->String {
        var value: Double = 0
        value = expenses.reduce(0, { partialResult, expense in
            return partialResult + (type == .all ? (expense.type == .income ? expense.amount : expense.amount) : (expense.type == type ? expense.amount : 0))
        })
        
       return convertNumberToPrice(value: value)
    }
    
    //MARK: Converting Selected Dates to string
    func ConvertDateToString()->String {
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    //MARK: Converting number to price
    func convertNumberToPrice(value: Double)-> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: value)) ?? "0.00"
    }
    
    //MARK: Clearing All Data
    func clearData() {
        date = Date()
        type = .all
        remark = ""
        amount = ""
    }
    
    //MARK: SAve Data
    func SaveData(env: EnvironmentValues) {
        //MARK: Do action here
        
        print("Save")
        //MARK: This is for Ui Demo
        //Replace with core data actions
        let amountInDouble = (amount as NSString).doubleValue
        let colors = ["Yellow","Red","Purple","Green"]
        let expense = Expense(remark: remark, amount: amountInDouble, date: date, type: type, color: colors.randomElement() ?? "Yellow")
        
        withAnimation {
            expenses.append(expense)
            expenses = expenses.sorted(by: { first, scnd in
                return scnd.date < first.date
            })
            env.dismiss()
        }
    }
}
