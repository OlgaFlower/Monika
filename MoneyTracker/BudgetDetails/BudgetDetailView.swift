//
//  BudgetDetailView.swift
//  Monika
//
//  Created by Olha Bereziuk on 06.04.25.
//

import SwiftUI

struct BudgetDetailView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var viewModel = BudgetDetailViewModel()
    @Binding var recordsUpdated: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.secondary.opacity(0.15))
                .ignoresSafeArea()
            ScrollView {
                if self.viewModel.monthIncomes.count != 0 {
                    self.makeList()
                }
            }
            .padding(.horizontal, 24)
            .onDisappear(perform: {
                self.recordsUpdated = true
            })
        }
    }
    
    private func makeList() -> some View {
        LazyVStack {
            TextHeader(text: "Month Income")
                .padding(.vertical, 24)
            ForEach(self.viewModel.monthIncomes, id: \.id) { record in
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
                    if let index = self.viewModel.monthIncomes.firstIndex(of: record) {
                        self.viewModel.deleteIncome(
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
    BudgetDetailView(recordsUpdated: .constant(false))
}
