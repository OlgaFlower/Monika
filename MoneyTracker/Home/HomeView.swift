//
//  HomeView.swift
//  Savvvy
//
//  Created by Olha Bereziuk on 14.12.24.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - States
    @StateObject var viewModel: HomeViewModel
    @State var isButtonActive: Bool = true
    @State private var isNewRecordPresented = false
    
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
                    SpentAndBudgetView(
                        spentMoneyAmount: self.$viewModel.todayExpenses,
                        budgetMoneyAmount: self.$viewModel.dayBudget
                    )
                    .padding(.top, 40)
                    .padding(.horizontal, 24)
                    
                    // Recent
                    self.makeRecentview()
                        .padding(.top, 40)
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    self.addNewRecord()
                        .padding(.trailing, 12)
                }
                .padding(.bottom, 12)
            }
        }
        .fullScreenCover(isPresented: self.$isNewRecordPresented, content: {
            NewRecordView(
                viewModel: NewRecordViewModel(),
                recordsUpdated: self.$viewModel.recordsUpdated) {
                    self.isNewRecordPresented.toggle()
                }
        })
        .onChange(of: self.viewModel.recordsUpdated) { _, newValue in
            if newValue {
                self.viewModel.updateValues()
            }
        }
    }
    
    //MARK: - Views
    private var backgroundView: some View {
        Color(uiColor: UIColor.secondarySystemBackground)
            .ignoresSafeArea()
    }
    
    private var addButtonView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 50, height: 50)
                .foregroundStyle(.blue)
            Image(systemName: "plus")
                .font(.system(size: 26, weight: .regular, design: .default))
                .foregroundStyle(.white)
        }
    }
    
    @ViewBuilder
    private func makeRecentview() -> some View {
        if self.viewModel.lastExpenseRecord != nil {
                ScrollView {
                    VStack(spacing: 10) {
                        TextHeader(text: "Recent")
                        RecordCell(lastRecord: self.viewModel.makeLastExpenseView())
                    }
                }
                .padding(.horizontal, 24)
        }
    }
    
    private func addNewRecord() -> some View {
        self.addButtonView
            .onTapGesture {
                VibrateService.vibrateMedium()
                self.isNewRecordPresented.toggle()
            }
    }
}

// MARK: - Preview
#Preview {
    HomeView(viewModel: HomeViewModel())
}
