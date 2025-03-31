//
//  Constants.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 22.04.24.
//

import SwiftUI

final class Constants {
    
    private init() {}
    
    // MARK: - Screen Width -
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85 // start,save btns
    static let buttonFillOpacity: Double = 0.1 //white background
    static let cornerRadius: CGFloat = 10.0
    static let strokeOpacity: Double = 0.8 // button line opacity
    static let strokeLineWidth: CGFloat = 0.5
    
    // MARK: - DropDown Menu -
    /// Add new record
    static let newRecordTypes = [RecordType.expense, RecordType.income]
    
}
