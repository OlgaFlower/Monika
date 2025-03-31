//
//  Currency.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 12.11.24.
//

import Foundation

enum Currency: String {

    case eur = "Euro (EUR)"
    case uah = "Ukrainian Hryvnia (UAH)"
    case cad = "Canadian Dollar (CAD)"
    
    var id: String {
        self.rawValue
    }
    
    var sign: String {
        
        switch self {
        case .eur:
            return "€" // Euro
        case .uah:
            return "₴" // Ukrainian Hryvnia
        case .cad:
            return "$" // CAD
        }
    }
}

// MARK: - Extension
extension Currency: PickerItem {}
