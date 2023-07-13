//
//  AddPaymentView.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/8/23.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = AddPaymentViewModel()
    var loan: Loan
    var payment: Payment?
    
  
    var save: some View {
        Button {
            viewModel.savePayment()
            dismiss()
        } label: {
            Text("Done")
                .fontWeight(.semibold)
        }
        .disabled(viewModel.isInvalidForm())
    }
    
    var body: some View {
        
            Form {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                DatePicker("Date", selection: $viewModel.date, in: ...Date(),
                           displayedComponents: .date)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    save
                }
            }
            .navigationTitle(payment != nil ? "Edit Payment" : "Add Payment")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                viewModel.setLoanObject(loan: loan)
                viewModel.setPaymentObject(payment: payment)
                viewModel.setUpEditView()
            }
        
    }
}


