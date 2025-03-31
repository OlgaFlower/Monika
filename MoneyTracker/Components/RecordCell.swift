//
//  RecordCell.swift
//  Monika
//
//  Created by Olha Bereziuk on 31.03.25.
//

import SwiftUI

struct RecordCell: View {
    
    @AppStorage("userCurrencySign") var currency: String = "$"
    var lastRecord: LastExpenseRecord
    
    var body: some View {
        ZStack {
            self.background
            HStack(spacing: 14) {
                self.iconView
                self.titleView
                self.moneyAmountView
            }
            .padding(.horizontal, 14)
        }
    }
    
    private var moneyAmountView: some View {
        Text("\(self.lastRecord.moneyAmount.toString()) \(self.currency)")
            .font(.system(size: 16, weight: .medium))
    }
    
    private var titleView: some View {
        VStack {
            HStack {
                Text(self.lastRecord.title)
                    .font(.system(size: 16, weight: .medium))
                Spacer()
            }
            HStack {
                Text(self.lastRecord.category)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
            }
        }
    }
    
    private var iconView: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(.blue.opacity(0.9))
            .frame(width: 45, height: 45)
            .overlay (
                Image(systemName: self.lastRecord.icon)
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
            )
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.background)
            .frame(height: 70)
    }
}

#Preview {
    ZStack {
        Rectangle()
            .fill(.black)
            .ignoresSafeArea()
        
        RecordCell(
            lastRecord: LastExpenseRecord(
                icon: "cup.and.saucer.fill",
                title: "Netflix Subscription",
                category: "Entertainment",
                moneyAmount: 3455
            )
        )
        .padding()
    }
}
