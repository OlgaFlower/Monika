//
//  MoneyTextView.swift
//  Monika
//
//  Created by Olha Bereziuk on 18.03.25.
//

import SwiftUI

struct MoneyTextView: View {
    
    @AppStorage("userCurrencySign") var currency: String = "$"
    @Binding var text: Int
    
    var body: some View {
        Text("\(self.text.toString()) \(self.currency)")
            .font(.system(size: 16, weight: .medium))
    }
}

#Preview {
    MoneyTextView(text: .constant(33456))
}
