//
//  BigIconView.swift
//  Monika
//
//  Created by Olha Bereziuk on 18.03.25.
//

import SwiftUI

struct BigIconView: View {
    
    let icon: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 45/2)
            .foregroundStyle(.pink.opacity(0.15))
            .frame(width: 45, height: 45)
            .overlay (
                Image(systemName: self.icon)
                    .foregroundColor(.pink)
                    .frame(width: 24, height: 24)
            )
    }
}

#Preview {
    BigIconView(icon: "minus.circle.fill")
}
