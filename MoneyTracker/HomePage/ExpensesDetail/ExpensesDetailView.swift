//
//  ExpensesDetailView.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 25.06.24.
//

import SwiftUI

struct ExpensesDetailView: View {
    // MARK: - State
    @Environment(\.managedObjectContext) var viewContext
    @StateObject private var viewModel = ExpensesDetailViewModel()
    
    // MARK: - DB
    private var todayExpensesFetchRequest = CoreDataManager.fetchExpensesForDay(date: Date())
    private var expensesRecords: FetchedResults<Money> {
        todayExpensesFetchRequest.wrappedValue
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            BackgroundGradView()
            VStack {
                HStack {
                    Text("EXPENSES TODAY")
                        .font(.customFont(style: .medium, size: .body))
                        .padding(.leading, 16)
                        .padding(.top)
                    Spacer()
                }
                List {
                    Section {
                        ForEach(self.viewModel.expenses) { record in
                            DetailCellView(
                                iconName: record.category.icon,
                                note: record.notes,
                                sum: record.moneyAmount
                            )
                        }
                        .onDelete { indexSet in
                            self.deleteItem(offsets: indexSet)
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.15))
                }
                .scrollContentBackground(.hidden)
            }
            .foregroundStyle(.white)
            .padding(.top, 28)
        }
        .onAppear {
            self.viewModel.getExpenses(records: self.expensesRecords)
        }
    }
    
    private func deleteItem(offsets: IndexSet) {
        
        for index in offsets {
            self.viewContext.delete(self.expensesRecords[index])
        }
        self.viewModel.expenses.remove(atOffsets: offsets)
        try? self.viewContext.save()
    }
}

#Preview {
    ExpensesDetailView()
}
