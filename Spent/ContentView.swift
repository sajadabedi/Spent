//
//  ContentView.swift
//  Spent
//
//  Created by Sajad Abedi on 08.09.2022.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModal
    
    var body: some View {
        HStack {
            NavigationView {
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24){
                        
                        // MARK: Chart
                        let data = transactionListVM.accumulateTransactions()
                        if !data.isEmpty {
                            let totalExpenses = data.last?.1 ?? 0
                            CardView {
                                VStack(alignment: .leading) {
                                    ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format: "$%.02f")
                                    LineChart()
                                }.background(Color.systemBackground)
                                
                            }
                            .data(data)
                            .chartStyle(ChartStyle(backgroundColor: Color.systemBackground,
                                                   foregroundColor: ColorGradient(Color.icon.opacity(0.4), .purple)))
                            .frame(height: 300)
                        }
                        
                        // MARK: Transactions
                        RecentTransactionList()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .background(Color.background)
                .toolbar {
                    // MARK: Notification Icon
                    ToolbarItem {
                        Image(systemName: "bell.badge")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.icon, .primary)
                    }
                }
                .navigationTitle("Overview")
            }
            .navigationViewStyle(.stack)
            .accentColor(.primary)
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModal = {
        let transactionListVM = TransactionListViewModal()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
