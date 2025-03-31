//
//  CategoryIconView.swift
//  Monika
//
//  Created by Olha Bereziuk on 11.03.25.
//

import SwiftUI

struct CategoryIconView: View {
    
    let icon: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 17)
            .foregroundStyle(.blue.opacity(0.9))
            .frame(width: 34, height: 34)
            .overlay (
                Image(systemName: self.icon)
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
            )
    }
}


#Preview {
    CategoryIconView(
        icon: "cup.and.saucer.fill"
    )
}
