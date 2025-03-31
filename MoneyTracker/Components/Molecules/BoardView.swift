//
//  BoardView.swift
//  Monika
//
//  Created by Olha Bereziuk on 18.03.25.
//

import SwiftUI

struct BoardView: View {
    
    @Binding var moneyAmount: Int
    var title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.background)
                .frame(height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                GreyTextView(text: self.title)
                MoneyTextView(text: self.$moneyAmount)
            }
        }
    }
}

#Preview {
    ZStack {
        Rectangle()
            .foregroundStyle(.red)
        
        BoardView(
            moneyAmount: .constant(355),
            title: "Spent"
        )
    }
}
