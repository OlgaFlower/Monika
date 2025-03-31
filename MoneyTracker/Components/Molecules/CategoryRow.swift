//
//  CategoryRow.swift
//  Monika
//
//  Created by Olha Bereziuk on 11.03.25.
//

import SwiftUI

struct CategoryRow: View {
    
    let category: Category
    let onSelect: () -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            CategoryIconView(
                icon: category.icon
            )
            CategoryLabel(text: category.name)
            Spacer()
        }
        .contentShape(Rectangle())
        .frame(height: 40)
        .onTapGesture {
            onSelect()
        }
    }
}

#Preview {
    CategoryRow(
        category: Category(
            name: "Eating out",
            icon: "cup.and.saucer.fill"
        ),
        onSelect: {}
    )
}
