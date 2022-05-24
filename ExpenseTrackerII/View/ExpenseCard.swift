//
//  ExpenseCard.swift
//  ExpenseTrackerII
//
//  Created by Sopnil Sohan on 23/5/22.
//

import SwiftUI

struct ExpenseCard: View {
    @ObservedObject var expenseViewModel: ExpenseViewModel
    var isFilterd: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8), Color.red.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            VStack(spacing: 15) {
                VStack(spacing: 15) {
                    //MARK: Currently going Month Date String
                    Text(isFilterd ? expenseViewModel.ConvertDateToString() : expenseViewModel.currentMonthDateString())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    //MARK: Current Month Expense Price
                    
                    Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses, type: .income))
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom, 5)
                }
                .offset(y: -10)
                
                HStack(spacing: 15) {
                    Image(systemName: "arrow.down")
                        .font(.caption.bold())
                        .foregroundColor(.green)
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.7), in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Income")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                        Image(systemName: "arrow.up")
                            .font(.caption.bold())
                            .foregroundColor(.red)
                            .frame(width: 30, height: 30)
                            .background(Color.white.opacity(0.7), in: Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Expense")
                                .font(.caption)
                                .opacity(0.7)
                            
                            Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses, type: .expense))
                                .font(.callout)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .fixedSize()
                        }
                }
                .padding(.horizontal)
                .padding(.trailing)
                .offset(y: 10)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 220)
        .padding(.top)
    }
}
