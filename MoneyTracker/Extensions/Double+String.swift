//
//  Double+String.swift
//  Monika
//
//  Created by Olha Bereziuk on 15.03.25.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
