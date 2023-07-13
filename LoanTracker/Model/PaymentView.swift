//
//  PaymentView.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/6/23.
//

import SwiftUI

struct PaymentView: View {
 
    @StateObject private var viewModel = PaymentViewModel()
    var loan: Loan
    
    
    @ViewBuilder
    private func progressView() -> some View {
        VStack {
            Text("Payment Progress")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)
            ProgressBar(progress: viewModel.progress)
                .padding(.horizontal)
            Text(viewModel.expectedToFinishOn)
                .font(.caption)
                .fontWeight(.light)
        }
    }
    
    
    @ViewBuilder
    private func addButton() -> some View {
        NavigationLink(value: Destination.addpayment(loan)) {
            Image(systemName: appToolbarImage)
                .font(.title3)
                .padding([.vertical,.leading],5)
        }
        
    }
    
    var body: some View {
        VStack {
           progressView()
            List {
                ForEach(viewModel.allPaymentObjects, id: \.sectionName) { paymentObject in
                    Section(header: Text("\(paymentObject.sectionName) - \(paymentObject.sectionTotal, format: .currency(code: "USD"))")) {
                        ForEach(paymentObject.sectionObject) { payment in
                            NavigationLink(value: Destination.addpayment(loan, payment)) {
                                PaymentCell(amount: payment.amount, date: payment.wrappedDate)
                            }
                        }
                        .onDelete { index in
                            viewModel.deleteItem(paymentObject: paymentObject, index: index)
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
        .navigationTitle(loan.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton()
            }
        }
        .onAppear {
            viewModel.setLoanObject(loan: loan)
            viewModel.calculateProgress()
            viewModel.calculateDays()
            viewModel.separateByYear()
            
        }
        
    }
}

struct PaymentView_Previews: PreviewProvider {
    // let loan = Loan()
    static var previews: some View {
        PaymentView(loan: Loan())
    }
}
