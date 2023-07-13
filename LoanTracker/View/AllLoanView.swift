//
//  ContentView.swift
//  LoanTracker
//
//  Created by Yogalakshmi Balasubramaniam on 5/4/23.
//

import SwiftUI
import CoreData

struct AllLoanView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var isAddLoanShowing = false
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Loan.startDate,
            ascending: true)],
        animation: .default
    )
    private var loans: FetchedResults<Loan>
    
    @ViewBuilder
    private func addButton() -> some View {
        Button {
            isAddLoanShowing.toggle()
        } label: {
            Image(systemName: appToolbarImage)
                .font(.title3)
        }
        .padding([.vertical,.leading],5)
    }
   
    var body: some View {
        NavigationStack {
            List {
                ForEach(loans) { loan in
                    NavigationLink(value: Destination.payment(loan)) {
                        LoanCell(name: loan.wrappedName, amount: loan.totalAmount, date: loan.wrappedDueDate)
                    }
                }
                .onDelete { index in
                    deleteItem(offset: index)
                }
            }
            
            .navigationTitle(appTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton()
                }
            }
            .sheet(isPresented: $isAddLoanShowing) {
                AddLoanView()
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .payment(let loan):
                    PaymentView(loan: loan)
                case .addpayment(let loan, let payment):
                    AddPaymentView(loan: loan, payment: payment)
                }
                
            }
            
        }
    }
    func deleteItem(offset: IndexSet) {
        withAnimation{
            offset.map { loans[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.save()
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllLoanView()
    }
}
