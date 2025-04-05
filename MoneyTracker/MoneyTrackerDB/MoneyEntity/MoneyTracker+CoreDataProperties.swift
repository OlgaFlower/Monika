//
//  MoneyTracker+CoreDataProperties.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 16.05.24.
//

import CoreData
import SwiftUI

extension Money {
    // MARK: - Properties
    @NSManaged public var categoryIcon: String
    @NSManaged public var categoryName: String
    @NSManaged public var categoryType: Int16
    @NSManaged public var id: UUID
    @NSManaged public var moneyAmount: Int64
    @NSManaged public var note: String?
    @NSManaged public var recurringRange: Int64
    @NSManaged public var recurringUnit: String
    @NSManaged public var timestamp: Date
}

extension Money {
    /// Create a new Money managed object from a Record instance in the given context.
    static func create(from record: Record, in context: NSManagedObjectContext) -> Money {
        let money = Money(context: context)
        Money.update(money: money, from: record)
        return money
    }
    
    /// Update an existing Money managed object using a Record instance.
    static func update(money: Money, from record: Record) {
        money.id = record.id
        money.categoryType = record.categoryType
        money.categoryName = record.category.name
        money.categoryIcon = record.category.icon
        money.timestamp = record.timestamp
        money.moneyAmount = record.moneyAmount
        money.note = record.note
        money.recurringUnit = record.recurringUnit
        money.recurringRange = record.recurringRange
    }
}

