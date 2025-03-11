//
//  CategoryList.swift
//  Monika
//
//  Created by Olha Bereziuk on 11.03.25.
//

import SwiftUI

struct CategoryList: View {
    
    let categoryGroup: CategoryGroup
    
    var body: some View {
        List {
            // If sections exist (for Recurring Expenses), show them
            if let sections = categoryGroup.sections {
                ForEach(sections) { section in
                    Section(header: Text(section.title)) {
                        ForEach(section.categories) { category in
                            CategoryRow(category: category)
                        }
                    }
                }
            } else {
                // Otherwise, show a plain list (for Expenses, Regular Income, One-time Income)
                ForEach(categoryGroup.subcategories) { category in
                    CategoryRow(category: category)
                }
            }
        }
    }
}

#Preview {
    CategoryList(categoryGroup: CategoryGroup(
        type: .recurringExpense,
        sections: [
            CategorySection(title: "Housing", categories: [
                Category(name: "Rent", icon: "house.fill", color: .orange),
                Category(name: "Mortgage", icon: "building.fill", color: .pink)
            ]),
            CategorySection(title: "Tech", categories: [
                Category(name: "Cell Phone", icon: "phone.fill", color: .blue),
                Category(name: "Apple One", icon: "applelogo", color: .black)
            ])
        ], subcategories: []
    ))
}
