//
//  AddLoanView.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/4/23.
//

import SwiftUI

struct AddLoanView: View {
    
    @StateObject var viewModel = AddLoanViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var cancel: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .fontWeight(.semibold)
        }
    }
    var save: some View {
        Button {
            viewModel.saveLoan()
            dismiss()
        } label: {
            Text("Done")
                .fontWeight(.semibold)
        }
        .disabled(viewModel.isInvalidForm())

    }
    var body: some View {
        
        NavigationStack {
            VStack {
                Form {
                    TextField("Name", text: $viewModel.name)
                        .autocapitalization(.sentences)
                    TextField("Amount", text: $viewModel.amount)
                        .keyboardType(.numberPad)
                    DatePicker("Start date", selection: $viewModel.startDate, in: ...Date(),
                               displayedComponents: .date)
                    DatePicker("Due date", selection: $viewModel.dueDate, in: viewModel.startDate..., displayedComponents: .date)
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancel
                       
                }
                ToolbarItem(placement: .confirmationAction) {
                    save
                       
                }
            }
        }
    }
}



