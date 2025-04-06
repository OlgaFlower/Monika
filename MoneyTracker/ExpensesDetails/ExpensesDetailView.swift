//
//  ExpensesDetailView.swift
//  Monika
//
//  Created by Olha Bereziuk on 01.04.25.
//

import SwiftUI

struct ExpensesDetailView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var viewModel = ExpensesDetailViewModel()
    @Binding var recordsUpdated: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.secondary.opacity(0.15))
                .ignoresSafeArea()
            ScrollView {
                if self.viewModel.recurringExpenses.count != 0 {
                    self.makeRecurringList()
                }
                
                if self.viewModel.generalExpenses.count != 0 {
                    self.makeGeneralList()
                }
            }
            .padding(.horizontal, 24)
            .onDisappear(perform: {
                self.recordsUpdated = true
            })
        }
    }
    
    private func makeRecurringList() -> some View {
        LazyVStack {
            TextHeader(text: "Recurring expenses")
                .padding(.vertical, 24)
            ForEach(self.viewModel.recurringExpenses, id: \.id) { record in
                SwipeToDeleteRow {
                    RecordCell(
                        record: ShortRecordForm(
                            id: record.id,
                            icon: record.category.icon,
                            title: record.note,
                            category: record.category.name,
                            moneyAmount: Int(record.moneyAmount)
                        )
                    )
                } onDelete: {
                    if let index = self.viewModel.recurringExpenses.firstIndex(of: record) {
                        self.viewModel.deleteRecurring(
                            at: index,
                            viewContext: self.viewContext
                        )
                    }
                }
            }
        }
    }
    
    private func makeGeneralList() -> some View {
        LazyVStack {
            TextHeader(text: "General expenses")
                .padding(.vertical, 24)
            ForEach(self.viewModel.generalExpenses, id: \.id) { record in
                SwipeToDeleteRow {
                    RecordCell(
                        record: ShortRecordForm(
                            id: record.id,
                            icon: record.category.icon,
                            title: record.note,
                            category: record.category.name,
                            moneyAmount: Int(record.moneyAmount)
                        )
                    )
                } onDelete: {
                    if let index = self.viewModel.generalExpenses.firstIndex(of: record) {
                        self.viewModel.deleteGeneral(
                            at: index,
                            viewContext: self.viewContext
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ExpensesDetailView(recordsUpdated: .constant(false))
}
