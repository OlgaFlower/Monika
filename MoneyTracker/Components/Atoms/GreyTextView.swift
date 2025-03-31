//
//  GreyTextView.swift
//  Monika
//
//  Created by Olha Bereziuk on 18.03.25.
//

import SwiftUI

struct GreyTextView: View {
    
    var text: String
    
    var body: some View {
        Text(self.text)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color.customGrey)
    }
}

#Preview {
    GreyTextView(text: "Spent")
}
