//
//  ExpensesDetailViewModel.swift
//  Monika
//
//  Created by Olha Bereziuk on 01.04.25.
//

import SwiftUI

final class ExpensesDetailViewModel: ObservableObject {
    
    @ObservedObject private var dataService: DataService
    
    @Published var generalExpenses: [Record] = []
    @Published var recurringExpenses: [Record] = []
    
    init(dataService: DataService = DataService.shared) {
        self.dataService = dataService
        self.splitExpenses()
    }
    
    private func splitExpenses() {
        // General expenses (categoryType == 0)
        self.generalExpenses = self.dataService.todayExpensesRecords.filter { $0.categoryType == 0 }
        print("General.count = \(generalExpenses.count)")
        
        // Recurring expenses (categoryType == 1)
        self.recurringExpenses = self.dataService.todayExpensesRecords.filter { $0.categoryType == 1 }
        print("Recurring.count = \(recurringExpenses.count)")
    }
}
