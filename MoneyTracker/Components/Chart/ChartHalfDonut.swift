//
//  ChartHalfDonut.swift
//  Monika
//
//  Created by Olha Bereziuk on 15.03.25.
//

import SwiftUI

struct ChartHalfDonut: GaugeStyle {
    
    @AppStorage("userCurrency") private var currency: String = "EUR"
    
    private let gradient = LinearGradient(
        gradient: Gradient(colors: [.lightBlue, .chartGreen, .red]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    private var screenWidth: CGFloat { Constants.screenWidth }
    
    
    // MARK: - Body
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            // Gray line
            Circle()
                .trim(from: 0, to: 1)
                .stroke(
                    Color.secondary.opacity(0.2),
                    style: StrokeStyle(
                        lineWidth: 16,
                        lineCap: .round
                    )
                )
            
            // Filled gradient line (actual progress)
            Circle()
                .trim(from: 0, to: 1 * configuration.value)
                .stroke(
                    .blue,
                    style: StrokeStyle(
                        lineWidth: 24,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            
            // Text in the center
            VStack(spacing: 12) {
                configuration.currentValueLabel
                
                Text(currency)
                    .foregroundColor(.green.opacity(0.9))
            }
            .padding(.top, 24)
        }
    }
}

struct ChartHalfDonut_Preview: View {
    var body: some View {
        Gauge(value: 0.7, in: 0...1) {
        } currentValueLabel: {
            Text("70%")
                .font(.title)
        }
        .gaugeStyle(ChartHalfDonut())
    }
}

struct ChartHalfDonut_Preview_Previews: PreviewProvider {
    static var previews: some View {
        ChartHalfDonut_Preview()
            .frame(width: 250, height: 250)
    }
}
