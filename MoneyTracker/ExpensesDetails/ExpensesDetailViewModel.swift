//
//  ExpensesDetailViewModel.swift
//  Monika
//
//  Created by Olha Bereziuk on 01.04.25.
//

import SwiftUI
import CoreData

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
        
        // Recurring expenses (categoryType == 1)
        self.recurringExpenses = self.dataService.todayExpensesRecords.filter { $0.categoryType == 1 }
    }
    
    func deleteRecurring(at index: Int, viewContext: NSManagedObjectContext) {
        let record = self.recurringExpenses[index]
        self.recurringExpenses.remove(at: index)
        self.dataService.deleteRecord(recordId: record.id, in: viewContext)
    }
    
    func deleteGeneral(at index: Int, viewContext: NSManagedObjectContext) {
        let record = self.generalExpenses[index]
        self.generalExpenses.remove(at: index)
        self.dataService.deleteRecord(recordId: record.id, in: viewContext)
    }
}
