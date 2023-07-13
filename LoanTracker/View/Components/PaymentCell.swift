//
//  PaymentCell.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/8/23.
//

import SwiftUI

struct PaymentCell: View {
    let amount: Double
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(amount, format: .currency(code: "USD"))
                .font(.headline)
                .fontWeight(.semibold)
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct PaymentCell_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCell(amount: 100, date: Date())
    }
}
