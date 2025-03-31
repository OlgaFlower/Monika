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
        
        VStack(alignment: .leading) {
            GreyTextView(text: self.title)
            MoneyTextView(text: self.$moneyAmount)
        }
    }
}

#Preview {
    BoardView(
        moneyAmount: .constant(355),
        title: "Spent"
    )
}
