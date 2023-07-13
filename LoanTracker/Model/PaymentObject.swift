//
//  PaymentObject.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/10/23.
//

import Foundation

struct PaymentObject: Equatable {
    var sectionName: String
    var sectionObject: [Payment]
    var sectionTotal: Double
}

