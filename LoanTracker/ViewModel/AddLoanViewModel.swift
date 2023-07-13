//
//  AllLoanViewModel.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/4/23.
//

import SwiftUI

final class AddLoanViewModel: ObservableObject {
    @Published var name = ""
    @Published var amount: String = ""
    @Published var startDate = Date()
    @Published var dueDate = Date()
    
    func saveLoan() {
        let loan = Loan(context: PersistenceController.shared.viewContext)
        loan.id = UUID().uuidString
        loan.name = name
        loan.totalAmount = Double(amount) ?? 0.0
        loan.startDate = startDate
        loan.dueDate = dueDate
        
        PersistenceController.shared.save()
        
    }
    
    func isInvalidForm() -> Bool {
        name.isEmpty || amount.isEmpty
    }
    
}


