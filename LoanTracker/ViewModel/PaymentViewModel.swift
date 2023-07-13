//
//  PaymentViewModel.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/8/23.
//

import SwiftUI

final class PaymentViewModel: ObservableObject {
    
    @Published private(set) var expectedToFinishOn = ""
    @Published private(set) var progress = Progress()
    @Published private(set) var allPayments: [Payment] = []
    @Published private(set) var allPaymentObjects: [PaymentObject] = []
    
    private var loan: Loan?
    
    
    func setLoanObject(loan: Loan) {
        self.loan = loan
        setPayments()
    }
    
    private func setPayments() {
        guard let loan = loan else { return }
        
        allPayments = loan.paymentArray
    }
    
    func calculateProgress() {
        guard let loan = loan else { return }
        
        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        let leftPaid = loan.totalAmount - totalPaid
        let value = totalPaid / loan.totalAmount
        
        progress = Progress(value: value, leftAmount: leftPaid, paidAmount: totalPaid)
    }
    func calculateDays() {
        guard let loan = loan else { return }
        
        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        let totalDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: loan.wrappedDueDate).day!
        let passedDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: Date()).day!
        if passedDays == 0 || totalPaid == 0 {
            expectedToFinishOn = ""
            return
        }
        let didPayPerDay = totalPaid / Double(passedDays)
        let shouldPayPerDay = loan.totalAmount / Double(totalDays)
        let daysLeftToFinish = (loan.totalAmount - totalPaid) / didPayPerDay
        let newDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish), to: Date())
        
        guard let newDate = newDate else {
            expectedToFinishOn = ""
            return
            
        }
        
        expectedToFinishOn = "Expected to finish by \(newDate.formatted(date: .long, time: .omitted))"
        if shouldPayPerDay > didPayPerDay {
            expectedToFinishOn += "(behind due date)"
        } else {
            expectedToFinishOn += "(ahead of due date)"
        }
        
    }
    func separateByYear() {
        allPaymentObjects = []
        
        let dict = Dictionary(grouping: allPayments) { $0.wrappedDate.intOfYear}
        
        for (key, value) in dict {
            guard let key = key else { return }
            
            let total = value.reduce(0) { $0 + $1.amount}
            allPaymentObjects.append(PaymentObject(sectionName: "\(key)",
                                                   sectionObject: value.reversed(),
                                                   sectionTotal: total))
        }
        allPaymentObjects.sort(by: {$0.sectionName > $1.sectionName })
    }
    
    func deleteItem(paymentObject: PaymentObject, index: IndexSet) {
        guard let deleteIndex = index.first else { return }
        
        let paymentToDelete = paymentObject.sectionObject[deleteIndex]
        
        PersistenceController.shared.viewContext.delete(paymentToDelete)
        PersistenceController.shared.save()
        
        setPayments()
        withAnimation {
            calculateProgress()
            calculateDays()
        }
        separateByYear()
    }
    
    
}


