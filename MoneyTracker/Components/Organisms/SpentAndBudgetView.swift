//
//  SpentAndBudgetView.swift
//  Monika
//
//  Created by Olha Bereziuk on 18.03.25.
//

import SwiftUI

struct SpentAndBudgetView: View {
    
    @Binding var spentMoneyAmount: Int
    @Binding var budgetMoneyAmount: Int
    
    var body: some View {
        HStack (spacing: 16) {
            BoardView(moneyAmount: self.$spentMoneyAmount, title: "Spent")
            BoardView(moneyAmount: self.$budgetMoneyAmount, title: "Budget")
        }
    }
}

#Preview {
    ZStack {
        Rectangle()
            .ignoresSafeArea()
        SpentAndBudgetView(spentMoneyAmount: .constant(239), budgetMoneyAmount: .constant(655))
    }
}
