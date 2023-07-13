//
//  Date + Extension.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/10/23.
//

import Foundation

extension Date {
    var intOfYear: Int? {
        Calendar.current.dateComponents([.year], from: self).year
    }
}
