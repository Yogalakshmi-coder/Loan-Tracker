//
//  LoanCell.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/5/23.
//

import SwiftUI

struct LoanCell: View {
    let name: String
    let amount: Double
    let date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(amount, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            
            Spacer()
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .fontWeight(.light)
        }
        
    }
}

struct LoanCell_Previews: PreviewProvider {
    static var previews: some View {
        LoanCell(name: "Loan1", amount: 10000, date: Date())
    }
}
