//
//  HomeViewModel.swift
//  Monika
//
//  Created by Olha Bereziuk on 14.03.25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @ObservedObject private var dataService: DataService
    
    @Published var todayExpenses: Int = 0
    @Published var dayBudget: Int = 0
    @Published var leftover: Int = 0
    @Published var recordsUpdated = false
    @Published var lastExpenseRecord: Record?
    
    init(dataService: DataService = DataService.shared) {
        self.dataService = dataService
        self.updateValues()
    }
    
    func updateValues(dataService: DataService = DataService.shared) {
        self.dataService.updateTodayMoneyValues()
        self.todayExpenses = self.dataService.todayExpensesSum
        self.dayBudget = self.dataService.dayBudget
        self.leftover = self.dataService.todayLeftover
        self.recordsUpdated = false
        self.lastExpenseRecord = self.dataService.getLastTodayExpense()
    }
    
    func makeLastExpenseView() -> LastExpenseRecord {
        guard let record = self.lastExpenseRecord else {
            return LastExpenseRecord(
                icon: "",
                title: "N/A",
                category: "",
                moneyAmount: 0
            )
        }
        
        return LastExpenseRecord(
            icon: record.category.icon,
            title: record.note,
            category: record.category.name,
            moneyAmount: Int(record.moneyAmount)
        )
    }
}
