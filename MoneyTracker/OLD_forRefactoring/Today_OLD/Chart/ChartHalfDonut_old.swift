//
//  ChartHalfDonut.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 01.04.24.
//

import SwiftUI

struct ChartHalfDonut_old: GaugeStyle {
    // "EUR" - default value
    @AppStorage("userCurrency") var currency: String = "EUR"
    
    // MARK: - Properties
    private var gradient = LinearGradient(gradient: Gradient(colors: [.lightBlue, .chartGreen, .red]), startPoint: .leading, endPoint: .trailing)
    private var gradientCircleWidth = Constants.screenWidth * 0.6
    private var dashesWidth = Constants.screenWidth * 0.73
    private var thinCircleWidth = Constants.screenWidth * 0.68
    var leftoverColor: Color
    var animateChart: Bool
    
    init(leftoverColor: Color, animateChart: Bool) {
        self.leftoverColor = leftoverColor
        self.animateChart = animateChart
    }
    
    // MARK: - Views
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack {
            /// Animated background circle
            Circle()
                .foregroundStyle(
                    LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .opacity(self.animateChart ? 0.5 : 0.0)
                .frame(width: self.thinCircleWidth - 22, height: self.thinCircleWidth - 22)
                .animation(.linear, value: self.animateChart)
            
            /// Thin circle
            Circle()
                .stroke(Color.white.opacity(0.9))
            
            /// Empty Gradient line
            Circle()
                .trim(from: 0, to: 1.0)
                .stroke(.white.opacity(0.1), style: StrokeStyle(lineWidth: self.animateChart ? 8 : 17, lineCap: .round))
                .rotationEffect(.degrees(153))
                .frame(width: self.animteSize())
                .animation(.linear, value: self.animateChart)
            
            /// Gradient line
            Circle()
                .trim(from: 0, to: 0.65 * configuration.value)
                .stroke(gradient, style: StrokeStyle(lineWidth: self.animateChart ? 27 : 17, lineCap: .round))
                .rotationEffect(.degrees(153))
                .frame(width: self.animateChart ? (self.gradientCircleWidth + 100) : self.gradientCircleWidth)
                .animation(.linear, value: self.animateChart)
            
            /// Dashes
            Circle()
                .trim(from: 0, to: 0.65)
                .stroke(Color.white.opacity(0.9), style: StrokeStyle(lineWidth: 9, lineCap: .butt, lineJoin: .round, dash: [1, 24], dashPhase: 10.0))
                .rotationEffect(.degrees(153))
                .frame(width: self.dashesWidth)
            
            VStack(spacing: 12) {
                
                /// Leftover sum
                configuration.currentValueLabel
                    .font(.title)
                    .foregroundColor(self.leftoverColor)
                
                /// Currency
                Text(self.currency)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white).opacity(0.9)
            }
            .padding(.top, 24)
        }
    }
    
    // MARK: - Functions
    private func animteSize() -> CGFloat {
        if self.animateChart {
            return self.gradientCircleWidth - 60
        } else {
            return self.gradientCircleWidth
        }
    }
}

