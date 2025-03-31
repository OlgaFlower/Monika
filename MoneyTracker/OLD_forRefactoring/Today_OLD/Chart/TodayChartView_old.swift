//
//  TodayChartView.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 26.06.24.
//

import SwiftUI

struct TodayChartView_old: View {
    
    // MARK: - Properties
    var animatedLeftover: Double
    var animatedBudget: Double
    var leftoverTextColor: Color
    var chartAnimated: Bool
    
    // MARK: - Body
    var body: some View {
        self.makeChart()
    }
    
    // MARK: - Views
    private func makeChart() -> some View {
        Gauge(
            value: self.animatedLeftover,
            in: 0...self.animatedBudget
        ) {
        } currentValueLabel: {
            Text("LEFTOVER")
                .foregroundStyle(.white.opacity(0.9))
            Text(self.animatedLeftover.formatAsCurrency())
                .contentTransition(.numericText())
                .animation(.linear, value: self.animatedLeftover)
        }
        .gaugeStyle(ChartHalfDonut_old(
            leftoverColor: self.leftoverTextColor,
            animateChart: self.chartAnimated)
        )
    }
}

// MARK: - Preview
#Preview {
    TodayChartView_old(
        animatedLeftover: 9.90,
        animatedBudget: 7.88,
        leftoverTextColor: .red,
        chartAnimated: false
    )
}
