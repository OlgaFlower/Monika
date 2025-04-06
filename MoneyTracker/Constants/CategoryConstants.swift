//
//  CategoryConstants.swift
//  Monika
//
//  Created by Olha Bereziuk on 11.03.25.
//

import Foundation

import SwiftUI

struct CategoryConstants {
    
    // MARK: - Expenses (One-time Purchases)
    static let expense = CategoryGroup(
        type: .generalExpense,
        sections: nil,
        subcategories: [
            // Daily Expenses
            Category(name: "Groceries", icon: "cart.fill"),
            Category(name: "Dining Out", icon: "fork.knife"),
            Category(name: "Coffee", icon: "cup.and.saucer.fill"),
            
            // Transportation
            Category(name: "Public Transport", icon: "bus.fill"),
            Category(name: "Gas", icon: "fuelpump.fill"),
            Category(name: "Taxi / Rideshare", icon: "car.fill"),
            
            // Housing
            Category(name: "Home Repairs", icon: "hammer.fill"),
            Category(name: "Furniture", icon: "bed.double.fill"),
            Category(name: "Appliances", icon: "stove.fill"),
            
            // Personal Care
            Category(name: "Haircuts", icon: "scissors"),
            Category(name: "Cosmetics", icon: "star"),
            Category(name: "Spa & Wellness", icon: "figure.mind.and.body"),
            
            // Shopping
            Category(name: "Clothing", icon: "tshirt.fill"),
            Category(name: "Shoes", icon: "shoe.fill"),
            Category(name: "Accessories", icon: "bag.fill"),
            
            // Entertainment
            Category(name: "Movies & Cinema", icon: "film.fill"),
            Category(name: "Concerts", icon: "music.note"),
            Category(name: "Gaming", icon: "gamecontroller.fill"),
            
            // Education
            Category(name: "Books", icon: "book.fill"),
            Category(name: "Courses", icon: "graduationcap.fill"),
            Category(name: "Workshops", icon: "pencil.and.ruler.fill")
        ]
    )
    
    // MARK: - Recurring Expenses (Bills, Subscriptions, Loans)
    static let recurringExpense = CategoryGroup(
        type: .recurringExpense,
        sections: [
            CategorySection(title: "Housing", categories: [
                Category(name: "Rent", icon: "house.fill"),
                Category(name: "Mortgage", icon: "building.fill"),
                Category(name: "Property Tax", icon: "doc.text.fill"),
                Category(name: "Home Insurance", icon: "shield.fill")
            ]),
            CategorySection(title: "Utilities", categories: [
                Category(name: "Electricity", icon: "bolt.fill"),
                Category(name: "Water Bill", icon: "drop.fill"),
                Category(name: "Gas Bill", icon: "flame.fill"),
                Category(name: "Internet", icon: "wifi"),
                Category(name: "Cable TV", icon: "tv.fill"),
                Category(name: "Cell Phone", icon: "phone.fill")
            ]),
            CategorySection(title: "Tech Subscriptions", categories: [
                Category(name: "Apple One", icon: "applelogo"),
                Category(name: "Spotify", icon: "music.note"),
                Category(name: "Netflix", icon: "film.fill"),
                Category(name: "Cloud Storage", icon: "externaldrive.fill")
            ]),
            CategorySection(title: "Health & Insurance", categories: [
                Category(name: "Health Insurance", icon: "cross.fill"),
                Category(name: "Life Insurance", icon: "heart.fill"),
                Category(name: "Gym Membership", icon: "figure.walk"),
                Category(name: "Medical Subscriptions", icon: "pills.fill")
            ]),
            CategorySection(title: "Loans & Financials", categories: [
                Category(name: "Car Loan", icon: "car.fill"),
                Category(name: "Student Loan", icon: "graduationcap.fill"),
                Category(name: "Credit Card Payments", icon: "creditcard.fill")
            ])
        ],
        subcategories: []
    )
    
    // MARK: - One-Time Income (Freelance, Side Hustles, Gifts)
    static let oneTimeIncome = CategoryGroup(
        type: .oneTimeIncome,
        sections: nil,
        subcategories: [
            Category(name: "Part-time Job", icon: "briefcase.fill"),
            Category(name: "Freelance Work", icon: "laptopcomputer"),
            Category(name: "Consulting", icon: "person.fill"),
            Category(name: "Bonus", icon: "gift.fill"),
            Category(name: "Stock Sales", icon: "chart.line.uptrend.xyaxis"),
            Category(name: "Property Sale", icon: "house.fill"),
            Category(name: "Lottery", icon: "dollarsign.circle.fill"),
            Category(name: "Selling Items", icon: "cart.badge.plus"),
            Category(name: "Gifts & Donations", icon: "giftcard.fill")
        ]
    )
    
    // MARK: - Regular Income (Salary, Investments, Passive Income)
    static let regularIncome = CategoryGroup(
        type: .regularIncome,
        sections: nil,
        subcategories: [
            Category(name: "Salary", icon: "dollarsign.circle.fill"),
            Category(name: "Hourly Wages", icon: "clock.fill"),
            Category(name: "Commissions", icon: "creditcard.fill"),
            Category(name: "Scholarship", icon: "graduationcap.fill"),
            Category(name: "Rental Income", icon: "house.fill"),
            Category(name: "Pension", icon: "person.fill"),
            Category(name: "Social Security", icon: "shield.fill"),
            Category(name: "Investment Returns", icon: "chart.line.uptrend.xyaxis"),
            Category(name: "Dividends", icon: "chart.bar.fill"),
            Category(name: "Royalties", icon: "music.note")
        ]
    )
    
    // MARK: - All Categories
    static let allCategories: [CategoryGroup] = [
        expense,
        recurringExpense,
        oneTimeIncome,
        regularIncome
    ]
}
