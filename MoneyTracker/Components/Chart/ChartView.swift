//
//  TodayChartView.swift
//  Monika
//
//  Created by Olha Bereziuk on 15.03.25.
//

import SwiftUI

struct ChartView: View {
    
    var animatedLeftover: Double
    var animatedBudget: Double
    var leftoverTextColor: Color
    var chartAnimated: Bool
    
    var body: some View {
        Gauge(
            value: animatedLeftover,
            in: 0...animatedBudget
        ) {} currentValueLabel: {
            // Label showing leftover text + leftover
            VStack(spacing: 4) {
                Text("LEFTOVER")
                    .foregroundColor(.pink)
                
                Text(" \(animatedLeftover.formatAsCurrency())")
                    .contentTransition(.numericText())
                    .animation(.linear, value: animatedLeftover)
            }
        }
        .gaugeStyle(
            ChartHalfDonut()
        )
    }
}

#Preview {
    ChartView(
        animatedLeftover: 240,
        animatedBudget: 788,
        leftoverTextColor: .red,
        chartAnimated: false
    )
    .frame(width: 250, height: 250)
}
