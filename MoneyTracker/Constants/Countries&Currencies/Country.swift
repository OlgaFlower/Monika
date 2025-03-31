//
//  Country.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 25.03.24.
//

import Foundation

enum Country: String, CaseIterable, Identifiable {
    
    case germany = "Germany"
    case austria = "Austria"
    case estonia = "Estonia"
    case ukraine = "Ukraine"
    case canada = "Canada"
    
    var id: String {
        self.rawValue
    }
}

// MARK: - Extension
extension Country: PickerItem {}
