//
//  Destination.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/8/23.
//

import Foundation

enum Destination: Hashable {
    case payment(Loan)
    case addpayment(Loan, Payment? = nil)
}
