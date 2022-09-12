//
//  RecentTransactionList.swift
//  Spent
//
//  Created by Sajad Abedi on 11.09.2022.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModal
    
    var body: some View {
        VStack {
            HStack {
                // MARK: Header
                Text("Recent Transactions")
                    .bold()
                Spacer()
                // MARK: Header Link
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            // MARK: Recent Transaction List
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id:\.element) { index, transaction in
                TransactionRow(transaction: transaction)
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.shadowElevation, radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModal = {
        let transactionListVM = TransactionListViewModal()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group {
            RecentTransactionList()
                .environmentObject(transactionListVM)
            RecentTransactionList()
                .preferredColorScheme(.dark)
                .environmentObject(transactionListVM)
        }
    }
}
