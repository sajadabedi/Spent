//
//  PreviewData.swift
//  Spent
//
//  Created by Sajad Abedi on 11.09.2022.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "24/01/2022", institution: "desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
