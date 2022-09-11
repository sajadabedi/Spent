//
//  SpentApp.swift
//  Spent
//
//  Created by Sajad Abedi on 08.09.2022.
//

import SwiftUI

@main
struct SpentApp: App {
    @StateObject var transactionListVM = TransactionListViewModal()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
