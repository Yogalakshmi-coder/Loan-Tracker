//
//  LoanTrackerApp.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/4/23.
//

import SwiftUI

@main
struct LoanTrackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            AllLoanView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
