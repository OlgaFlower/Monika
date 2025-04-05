//
//  ExpensesDetailView.swift
//  Monika
//
//  Created by Olha Bereziuk on 01.04.25.
//

import SwiftUI

struct ExpensesDetailView: View {
    
    @StateObject var viewModel = ExpensesDetailViewModel()
    
    var body: some View {
        ScrollView {
            if self.viewModel.recurringExpenses.count != 0 {
                self.makeRecurringList()
            }
            
            if self.viewModel.generalExpenses.count != 0 {
                self.makeGeneralList()
            }
        }
        .padding(24)
    }
    
    private func makeRecurringList() -> some View {
        VStack {
            TextHeader(text: "Recurring expenses")
            ForEach(self.viewModel.recurringExpenses, id: \.id) { record in
                RecordCell(
                    record: ShortRecordForm(
                        id: record.id,
                        icon: record.category.icon,
                        title: record.note,
                        category: record.category.name,
                        moneyAmount: Int(record.moneyAmount)
                    )
                )
            }
        }
    }
    
    private func makeGeneralList() -> some View {
        VStack {
            TextHeader(text: "General expenses")
            ForEach(self.viewModel.generalExpenses, id: \.id) { record in
                RecordCell(
                    record: ShortRecordForm(
                        id: record.id,
                        icon: record.category.icon,
                        title: record.note,
                        category: record.category.name,
                        moneyAmount: Int(record.moneyAmount)
                    )
                )
            }
        }
    }
}

#Preview {
    ExpensesDetailView()
}
