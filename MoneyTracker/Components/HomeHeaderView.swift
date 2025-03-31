//
//  HomeHeaderView.swift
//  Monika
//
//  Created by Olha Bereziuk on 15.12.24.
//

import SwiftUI

struct HomeHeaderView: View {
    
    // MARK: - Body
    var body: some View {
        
        VStack(spacing: -4) {
            HStack {
                self.dayOfWeekView
                self.monthView
            }
            self.yearView
        }
        .padding(.top)
    }
    
    // MARK: - Views
    private var dayOfWeekView: some View {
        HStack {
            Text(CalendarManager.shared.weekdayAbbreviation())
                .font(.system(size: 35, weight: .bold, design: .default))
            Circle()
                .frame(height: 25)
                .foregroundStyle(.pink)
                .padding(.top, 1)
        }
        .frame(height: 25)
    }
    
    private var monthView: some View {
        HStack {
            Spacer()
            Text(CalendarManager.shared.monthAndDay())
                .font(.system(size: 18, weight: .bold, design: .default))
                .foregroundStyle(Color(uiColor: .secondaryLabel))
        }
        .frame(height: 25)
    }

    private var yearView: some View {
        HStack {
            Spacer()
            Text(CalendarManager.shared.year())
                .font(.system(size: 18, weight: .bold, design: .default))
                .foregroundStyle(Color(uiColor: .tertiaryLabel))
        }
    }
}

#Preview {
    HomeHeaderView()
}
