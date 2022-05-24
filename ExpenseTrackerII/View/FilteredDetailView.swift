//
//  FilteredDetailView.swift
//  ExpenseTrackerII
//
//  Created by Sopnil Sohan on 23/5/22.
//

import SwiftUI

struct FilteredDetailView: View {
    @ObservedObject var expenseViewModel: ExpenseViewModel
    @Environment(\.self) var env
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack(spacing: 15) {
                    //MARK: Back Button
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(
                                Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                            )
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    Text("Transactions")
                        .font(.title2.bold())
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        expenseViewModel.showFilterView = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(
                                Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                            )
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                
                //MARK: Expense Card View For Currently Selected Date
                ExpenseCard(expenseViewModel: expenseViewModel, isFilterd: true)
                
                CustomSegmentControl(expenseViewModel: expenseViewModel)
                    .padding(.top)
                
                //MARK: Current filtered date with amount
                VStack(spacing: 15) {
                    Text(expenseViewModel.ConvertDateToString())
                        .opacity(0.7)
                    Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses, type: expenseViewModel.tabName))
                        .font(.title.bold())
                        .opacity(0.9)
                        .animation(.none, value: expenseViewModel.tabName)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background (
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                    )
                .padding(.vertical, 20)
                
                ForEach(expenseViewModel.expenses.filter{
                    return $0.type == expenseViewModel.tabName
                }) { expense in
                    TransactionCardView(expense: expense, expenseViewModel: expenseViewModel)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .background(
        Color("BG")
            .ignoresSafeArea()
        )
        .overlay{
            FilterView()
        }
    }
    
    @ViewBuilder
    func FilterView()->some View {
        ZStack {
            Color.black
                .opacity(expenseViewModel.showFilterView ? 0.25 : 0)
                .ignoresSafeArea()
            //MARK: BAsed on the Date Filter Expense Array
            if expenseViewModel.showFilterView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 80) {
                        Text("Start Date")
                            .font(.caption)
                            .opacity(0.7)
                        
                        //MARK: Close Button
                        Image(systemName: "xmark.circle.fill")
                            .padding(5)
                            .foregroundColor(.black)
                            .onTapGesture {
                                expenseViewModel.showFilterView = false
                            }
                    }
                    DatePicker("", selection: $expenseViewModel.startDate, in: Date.distantPast...Date(),displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                    Text("End Date")
                        .font(.caption)
                        .opacity(0.7)
                        .padding(.top, 10)
                    
                    DatePicker("", selection: $expenseViewModel.endDate, in: Date.distantPast...Date(),displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                }
                .padding(20)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
            }
            
        }
        .animation(.easeInOut, value: expenseViewModel.showFilterView)
    }
}

struct CustomSegmentControl: View {
    @ObservedObject var expenseViewModel: ExpenseViewModel
    @Namespace var animation
    var body: some View {
        HStack(spacing: 0) {
            ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue) { tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(expenseViewModel.tabName == tab ? .white : .black)
                    .opacity(expenseViewModel.tabName == tab ? 1 : 0.7)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background{
                    //MARK: With Matched geometry effect
                        if expenseViewModel.tabName == tab {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(.linearGradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8), Color.red.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            expenseViewModel.tabName = tab
                        }
                    }
            }
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
        )
    }
}

struct FilteredDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredDetailView(expenseViewModel: ExpenseViewModel())
    }
}
