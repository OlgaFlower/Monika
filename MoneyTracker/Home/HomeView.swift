//
//  HomeView.swift
//  Savvvy
//
//  Created by Olha Bereziuk on 14.12.24.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - States
    @ObservedObject var viewModel: HomeViewModel
    @State var isButtonActive: Bool = true
    @State var showDetailedExpenses = false
    @State var showBudget = false
    
    let showWelcomeView = false
    
    // MARK: - Body
    var body: some View {
        
        ZStack {
            self.backgroundView
            VStack(spacing: 0) {
                HomeHeaderView()
                    .padding(.horizontal)
                
                // Calendar line
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(height: 55)
                    .padding(.top, 17)
                
                if showWelcomeView {
                    WelcomeView()
                    
                } else {
                    ChartView(
                        animatedLeftover: self.viewModel.leftover.formattToDouble(),
                        animatedBudget: self.viewModel.dayBudget.formattToDouble(),
                        leftoverTextColor: .pink,
                        chartAnimated: false
                    )
                    .frame(width: 230, height: 230)
                    .padding(.top, 40)
                    
                    // Spent + Budget
                    HStack (spacing: 16) {
                        self.makeSpentView()
                        self.makeBudgetView()
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 24)
                    
                    // Recent
                    self.makeRecentview()
                        .padding(.top, 40)
                }
                
                Spacer()
            }
        }
        .onChange(of: self.viewModel.recordsUpdated) { _, newValue in
            if newValue {
                self.viewModel.updateValues()
            }
        }
        .sheet(isPresented: self.$showDetailedExpenses, content: {
            ExpensesDetailView()
        })
    }
    
    //MARK: - Views
    private var backgroundView: some View {
        Color(uiColor: UIColor.secondarySystemBackground)
            .ignoresSafeArea()
    }
    
    private func makeSpentView() -> some View {
        BoardView(moneyAmount: self.$viewModel.todayExpenses, title: "Spent")
            .onTapGesture {
                self.showDetailedExpenses.toggle()
            }
    }
    
    private func makeBudgetView() -> some View {
        BoardView(moneyAmount: self.$viewModel.dayBudget, title: "Budget")
            .onTapGesture {
                self.showBudget.toggle()
            }
    }
    
    @ViewBuilder
    private func makeRecentview() -> some View {
        if self.viewModel.lastExpenseRecord != nil {
            VStack(spacing: 10) {
                TextHeader(text: "Recent")
                RecordCell(record: self.viewModel.makeLastExpenseView())
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView(viewModel: HomeViewModel())
}
