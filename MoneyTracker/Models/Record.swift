//
//  Record.swift
//  Monika
//
//  Created by Olha Bereziuk on 13.03.25.
//

import Foundation

struct Record: Identifiable, Equatable {
    var id: UUID = UUID()
    var categoryType: Int16
    var category: Category
    var note: String
    var moneyAmount: Int64
    var timestamp: Date
    var recurringUnit: String
    var recurringRange: Int64
    
    static func == (lhs: Record, rhs: Record) -> Bool {
        return lhs.id == rhs.id &&
        lhs.categoryType == rhs.categoryType &&
        lhs.category == rhs.category &&
        lhs.note == rhs.note &&
        lhs.moneyAmount == rhs.moneyAmount &&
        lhs.timestamp == rhs.timestamp &&
        lhs.recurringUnit == rhs.recurringUnit &&
        lhs.recurringRange == rhs.recurringRange
    }
}

extension Record {
    init(managedObject money: Money) {
        self.id = money.id
        self.categoryType = money.categoryType
        self.category = Category(
            name: money.categoryName,
            icon: money.categoryIcon
        )
        self.note = money.note ?? ""
        self.moneyAmount = money.moneyAmount
        self.timestamp = money.timestamp
        self.recurringUnit = money.recurringUnit
        self.recurringRange = money.recurringRange
    }
}
