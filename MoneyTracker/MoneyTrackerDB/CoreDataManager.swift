//
//  CoreDataManager.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 18.06.24.
//

import CoreData
import SwiftUI

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Records by Date
    func fetchRecords(for date: Date) -> [Record] {
        let request = NSFetchRequest<Money>(entityName: "Money")
        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            Calendar.current.startOfDay(for: date) as NSDate,
            Calendar.current.date(
                byAdding: .day,
                value: 1,
                to: Calendar.current.startOfDay(for: date)
            )! as NSDate
        )
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            return MappingService.mapDataToMoneyModel(recordsData: result)
        } catch let error {
            print("Error fetching records: \(error)")
        }
        return []
    }
    
    // MARK: - Record by ID
    func fetchRecordById(recordId: String) -> Record? {
        let request = NSFetchRequest<Money>(entityName: "Money")
        request.predicate = NSPredicate(format: "id == %@", recordId)
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            if !result.isEmpty {
                let records = MappingService.mapDataToMoneyModel(recordsData: result)
                return records.first
            }
        } catch let error {
            print("Error fetching record by ID: \(error)")
        }
        return nil
    }
    
    // MARK: - Expenses for Day
    func fetchExpensesForDay(date: Date) -> [Record] {
        let request = NSFetchRequest<Money>(entityName: "Money")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Money.timestamp, ascending: true)]
        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@ AND (categoryType == %d OR categoryType == %d)",
            Calendar.current.startOfDay(for: date) as NSDate,
            Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: date))! as NSDate,
            0,
            1
        )
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            return MappingService.mapDataToMoneyModel(recordsData: result)
        } catch let error {
            print("Error fetching expenses for day: \(error)")
        }
        return []
    }
    
    // MARK: - Last Expense for Day
    func fetchLastTodayExpense() -> Record? {
        let date = Date()
        let request = NSFetchRequest<Money>(entityName: "Money")
        // Sort by timestamp descending so the most recent record is first
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Money.timestamp, ascending: false)]
        // Limit to one result
        request.fetchLimit = 1
        
        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@ AND (categoryType == %d OR categoryType == %d)",
            Calendar.current.startOfDay(for: date) as NSDate,
            Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: date))! as NSDate,
            0,
            1
        )
        
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            if let lastExpense = result.first {
                // Map the fetched Money object to your Record model.
                return MappingService.mapDataToMoneyModel(recordsData: [lastExpense]).first
            }
        } catch {
            print("Error fetching last expense for day: \(error)")
        }
        
        return nil
    }
    
    // MARK: - Month Income
    func fetchMonthIncomeRecords(for month: Int, year: Int) -> [Record] {
        let calendar = Calendar.current
        
        // Create date components for the specified month and year.
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        
        // Get the start of the specified month.
        guard let startOfMonth = calendar.date(from: dateComponents) else {
            fatalError("Could not determine start of the specified month.")
        }
        
        // Get the start of the next month.
        guard let startOfNextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth) else {
            fatalError("Could not determine start of the next month.")
        }
        
        let request = NSFetchRequest<Money>(entityName: "Money")
        
        let timestampPredicate = NSPredicate(format: "timestamp >= %@ AND timestamp < %@", startOfMonth as NSDate, startOfNextMonth as NSDate)
        let categoryTypePredicate = NSPredicate(format: "categoryType == %d OR categoryType == %d", 2, 3)
        
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timestampPredicate, categoryTypePredicate])
        request.predicate = combinedPredicate
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Money.timestamp, ascending: true)]
        
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            return MappingService.mapDataToMoneyModel(recordsData: result)
        } catch let error {
            print("Error fetching month income records: \(error)")
        }
        
        return []
    }
    
    // MARK: - Delete Record by ID
    func deleteRecord(recordId: String, in viewContext: NSManagedObjectContext) {
        let request = NSFetchRequest<Money>(entityName: "Money")
        request.predicate = NSPredicate(format: "id == %@", recordId)
        
        do {
            let results = try viewContext.fetch(request)
            if let itemObject = results.first {
                viewContext.delete(itemObject)
            }
        } catch {
            print("Error fetching object to delete: \(error)")
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving context after deletion: \(error)")
        }
    }
    
    // MARK: - Make New Record / Update Existing Record
    func makeNewRecord(from record: Record, using managedObjectContext: NSManagedObjectContext) {
        let request = NSFetchRequest<Money>(entityName: "Money")
        request.predicate = NSPredicate(format: "id == %@", record.id.uuidString)
        
        do {
            let results = try managedObjectContext.fetch(request)
            if let existingRecord = results.first {
                // Use the static update helper.
                Money.update(money: existingRecord, from: record)
            } else {
                let newRecord = Money(context: managedObjectContext)
                Money.update(money: newRecord, from: record)
            }
            
            try managedObjectContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // MARK: - Delete All Objects
    static func deleteAllObjects(context: NSManagedObjectContext) {
        let persistentStoreCoordinator = context.persistentStoreCoordinator
        let entities = persistentStoreCoordinator?.managedObjectModel.entities
        
        entities?.forEach { entity in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(batchDeleteRequest)
                try context.save()
                print("ALL objects DELETED!")
            } catch {
                print("Failed to delete objects for entity \(entity.name!): \(error)")
            }
        }
    }
}
