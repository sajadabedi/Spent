//
//  TransactionListViewModel.swift
//  Spent
//
//  Created by Sajad Abedi on 11.09.2022.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModal: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions", error.localizedDescription)
                case .finished: break
                }
                
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else {return [:]}
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }
        return groupedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else {return []}
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum: Double = .zero
        var cumlativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAMount}
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumlativeSum.append((date.formatted(), sum))
        }
        return cumlativeSum
    }
}
