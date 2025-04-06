//
//  BudgetDetailViewModel.swift
//  Monika
//
//  Created by Olha Bereziuk on 06.04.25.
//

import SwiftUI
import CoreData

final class BudgetDetailViewModel: ObservableObject {
    
    @ObservedObject private var dataService: DataService
    
    @Published var monthIncomes: [Record] = []
    
    init(dataService: DataService = DataService.shared) {
        self.dataService = dataService
        self.getIncomes()
    }
    
    private func getIncomes() {
        guard let incomes = self.dataService.getCurrentMonthIncomes() else { return }
        self.monthIncomes = incomes
    }
    
    func deleteIncome(at index: Int, viewContext: NSManagedObjectContext) {
        let record = self.monthIncomes[index]
        self.monthIncomes.remove(at: index)
        self.dataService.deleteRecord(recordId: record.id, in: viewContext)
    }
}
