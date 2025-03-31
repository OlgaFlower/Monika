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
            self.background
            
            VStack(alignment: .leading, spacing: 4) {
                GreyTextView(text: self.title)
                MoneyTextView(text: self.$moneyAmount)
            }
        }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.background)
            .frame(height: 70)
    }
}

#Preview {
    ZStack {
        Rectangle()
            .foregroundStyle(.black)
            .ignoresSafeArea()
        
        BoardView(
            moneyAmount: .constant(355),
            title: "Spent"
        )
        .padding()
    }
}
