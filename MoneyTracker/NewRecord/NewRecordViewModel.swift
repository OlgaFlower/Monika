//
//  NewRecordViewModel.swift
//  Monika
//
//  Created by Olha Bereziuk on 23.12.24.
//

import Foundation
import CoreData

final class NewRecordViewModel: ObservableObject {
    
    @Published var newRecord = Record(
        categoryType: CategoryType.generalExpense.rawValue,
        category: Category(
            name: "",
            icon: ""
        ),
        note: "",
        moneyAmount: 0,
        timestamp: Date(),
        recurringUnit: "",
        recurringRange: 0
    )
    
    @Published var segemntedControlTag: Int = 0 // Segmented control - Expense/Income (0/1)
    @Published var inputAmount = ""
    @Published var currencySign = UserPreferences.currencySign
    @Published var recurringCatTapped = false
    @Published var recurringRange: Int = 1 // 1 -> 2 -> 3
    @Published var recurringUnit: RecurringUnit = .days // Days -> Weeks -> Months -> Years
    @Published var categoryType: CategoryType = .generalExpense
    
    let controlOptions = ["Expense", "Income"]
    
    var regularCatPrepared: Bool {
        guard let type = CategoryType(rawValue: self.newRecord.categoryType) else { return false }
        return (type == .generalExpense || type == .oneTimeIncome)
        && !self.newRecord.category.name.isEmpty
    }
    
    var recurringCatPrepared: Bool {
        guard let type = CategoryType(rawValue: self.newRecord.categoryType) else { return false }
        
        return (type == .recurringExpense || type == .regularIncome)
        && !self.newRecord.category.name.isEmpty
    }
    
    var activateSaveBtn: Bool {
        ((self.regularCatPrepared || self.recurringCatPrepared) && !self.inputAmount.isEmpty)
    }
    
    var regularCatTitle: String {
        let title = segemntedControlTag == 0 ? "General" : "One-Time"
        return self.regularCatPrepared ? self.newRecord.category.name : title
    }
    
    var generalCatIcon: String {
        let inactiveIcon = segemntedControlTag == 0 ? "cart.circle.fill" : "dollarsign.circle.fill"
        return self.regularCatPrepared ? self.newRecord.category.icon : inactiveIcon
    }
    
    var recurringCatTitle: String {
        let title = segemntedControlTag == 0 ? "Recurring" : "Regular"
        return self.recurringCatPrepared ? self.newRecord.category.name : title
    }
    
    var recurringCatIcon: String {
        self.recurringCatPrepared ? self.newRecord.category.icon : "repeat.circle.fill"
    }
    
    var isSaveBtnActive: Bool {
        self.newRecord.moneyAmount != 0 && !self.newRecord.category.name.isEmpty
    }
    
    func reduceRange() {
        self.recurringRange = max(1, self.recurringRange - 1)
    }
    
    func increaseRange() {
        self.recurringRange += 1
    }
    
    // Backward
    func previousUnit() {
        let allUnits = RecurringUnit.allCases
        guard let currentIndex = allUnits.firstIndex(of: recurringUnit) else { return }
        let newIndex = (currentIndex - 1 + allUnits.count) % allUnits.count
        recurringUnit = allUnits[newIndex]
    }
    
    // Forward
    func nextUnit() {
        let allUnits = RecurringUnit.allCases
        guard let currentIndex = allUnits.firstIndex(of: recurringUnit) else { return }
        let newIndex = (currentIndex + 1) % allUnits.count
        recurringUnit = allUnits[newIndex]
    }
    
    func setupNewRecordCategoryType() {
        if self.segemntedControlTag == 0, !self.recurringCatTapped {
            self.newRecord.categoryType = CategoryType.generalExpense.rawValue
            print(self.newRecord.categoryType)
        }
        if self.segemntedControlTag == 0, self.recurringCatTapped {
            self.newRecord.categoryType = CategoryType.recurringExpense.rawValue
            print(self.newRecord.categoryType)
        }
        if self.segemntedControlTag == 1, !self.recurringCatTapped {
            self.newRecord.categoryType = CategoryType.oneTimeIncome.rawValue
            print(self.newRecord.categoryType)
        }
        if self.segemntedControlTag == 1, self.recurringCatTapped {
            self.newRecord.categoryType = CategoryType.regularIncome.rawValue
            print(self.newRecord.categoryType)
        }
    }
    
    func setCategoryToDefault() {
        self.newRecord.category = Category(name: "", icon: "")
    }
    
    func saveNewRecord(context: NSManagedObjectContext) {
        let moneyAmount = self.inputAmount.toInt64()
        if moneyAmount != 0,
           !self.newRecord.category.name.isEmpty {
            
            self.newRecord.moneyAmount = moneyAmount
            self.newRecord.recurringUnit = self.recurringUnit.rawValue
            self.newRecord.recurringRange = Int64(self.recurringRange)
            
            CoreDataManager.shared.makeNewRecord(from: self.newRecord, using: context)
        }
    }
}
