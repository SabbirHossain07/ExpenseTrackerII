
//  Home.swift
//  ExpenseTrackerII
//
//  Created by Sopnil Sohan on 22/5/22.
//

import SwiftUI

struct Home: View {
    @StateObject var expenseViewModel: ExpenseViewModel = .init()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome!")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Text("Sabbir Hossain")
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    NavigationLink {
                        FilteredDetailView(expenseViewModel: expenseViewModel)
//                            .environmentObject(expenseViewModel)
                    } label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(content: {
                                Circle()
                                    .stroke(.white, lineWidth: 2)
                                    .padding(7)
                            })
                            .frame(width: 40, height: 40)
                            .background(
                                Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                            )
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }

                }
                
                ExpenseCard(expenseViewModel: expenseViewModel)
                
                TransactionView()
            }
            .padding()
        }
        .background(
            Color("BG")
                .ignoresSafeArea()
        )
        .fullScreenCover(isPresented: $expenseViewModel.addNewExpense) {
            expenseViewModel.clearData()
        } content: {
            NewExpense(expenseViewModel: expenseViewModel)
        }
        .overlay(alignment: .bottomTrailing) {
            AddButton()
        }

    }
    
    //MARK: Aadd New expense button
    @ViewBuilder
    func AddButton()->some View {
        Button {
            expenseViewModel.addNewExpense.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background(
                Circle()
                    .fill(.linearGradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8), Color.red.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
        .padding()

    }

    
    //MARK: Transaction View
    @ViewBuilder
    func TransactionView()->some View {
        VStack(spacing: 15) {
            Text("Transactions")
                .font(.title2.bold())
                .opacity(0.7)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            
            ForEach(expenseViewModel.expenses) { expense in
                //MARK: Transaction Card View
                TransactionCardView(expense: expense, expenseViewModel: expenseViewModel)
            }
        }
        .padding(.top)
    }
   
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
