//
//  TextHeader.swift
//  Monika
//
//  Created by Olha Bereziuk on 31.03.25.
//

import SwiftUI

struct TextHeader: View {
    
    var text: String
    
    var body: some View {
        VStack {
            HStack {
                Text(self.text)
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
            }
            .padding(.vertical)
        }
        .frame(height: 18)
    }
}

#Preview {
    TextHeader(text: "Recent")
}
