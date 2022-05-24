//
//  TransactionCardView.swift
//  ExpenseTrackerII
//
//  Created by Sopnil Sohan on 22/5/22.
//

import SwiftUI

struct TransactionCardView: View {
    var expense: Expense
    @ObservedObject var expenseViewModel: ExpenseViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            //MARK: First letter Avater
            if let first = expense.remark.first {
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(Color(expense.color))
                    )
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
            }
            
            Text(expense.remark)
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing, spacing: 7) {
                //MARK: Displaying Price
                let price = expenseViewModel.convertNumberToPrice(value: expense.type == .expense ? -expense.amount : expense.amount)
                
                Text(price)
                    .font(.callout)
                    .opacity(0.7)
                    .foregroundColor(expense.type == .expense ? Color("Red") : Color("Green"))
                
                Text(expense.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.ultraThickMaterial)
        )
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
