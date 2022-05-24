//
//  NewExpense.swift
//  ExpenseTrackerII
//
//  Created by Sopnil Sohan on 23/5/22.
//

import SwiftUI

struct NewExpense: View {
    @ObservedObject var expenseViewModel: ExpenseViewModel
    @Environment(\.self) var env
    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Text("Add Expenses")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                
                //MARK: Custom Text Fild
                //for currency symbol
                
                if let symbol =
                    expenseViewModel.convertNumberToPrice(value: 0).first {
                    TextField("0", text: $expenseViewModel.amount)
                        .font(.system(size: 35))
                        .foregroundColor(Color.purple.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background(
                            Text(expenseViewModel.amount == "" ? "0" : expenseViewModel.amount)
                                .font(.system(size: 35))
                                .opacity(0)
                                .overlay(alignment: .leading){
                                    Text(String(symbol))
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                }
                        )
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                        Capsule()
                            .fill(.white)
                            
                        )
                        .padding(.horizontal,20)
                        .padding(.top)
                }
                
                //MARK: Custom Lable
                Label {
                    TextField("remark", text: $expenseViewModel.remark)
                        .padding(.leading, 10)
                       
                } icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(Color.gray)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                
                )
                .padding(.top, 25)
                
                Label {
                //MARK: Checkboxes
                    CustomCheckBoxes()
                       
                } icon: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundColor(Color.gray)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                
                )
                .padding(.top, 5)
                
                Label {
                    DatePicker.init("", selection: $expenseViewModel.date,in: Date.distantPast...Date(),displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                } icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color.gray)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                
                )
                .padding(.top, 5)
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
            //MARK: Save Button
            Button {
                expenseViewModel.SaveData(env: env)
            } label: {
                Text("Save")
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.linearGradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8), Color.red.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                    .padding(.bottom, 10)
            }
            .disabled(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == "")
            .opacity(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == "" ? 0.6 : 1)

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG").ignoresSafeArea())
        .overlay(
            alignment: .topTrailing) {
                //MARK: Close Button
                Button {
                    env.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black)
                        .opacity(0.7)
                }
                .padding()
            }
    }
    
    @ViewBuilder
    func CustomCheckBoxes()->some View {
        HStack(spacing: 10) {
            ForEach([ExpenseType.income, ExpenseType.expense], id: \.self) { type in
                ZStack {
                    RoundedRectangle(cornerRadius: 2, style: .continuous)
                        .stroke(.black, lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20, height: 20)
                    
                    if expenseViewModel.type == type {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(Color("Green"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    expenseViewModel.type = type
                }
                
                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.7)
                    .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.leading, 10)
    }
}

struct NewExpense_Previews: PreviewProvider {
    static var previews: some View {
        NewExpense(expenseViewModel: ExpenseViewModel())
           
    }
}
