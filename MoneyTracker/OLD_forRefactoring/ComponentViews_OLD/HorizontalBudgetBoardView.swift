////
////  HorizontalBudgetBoardView.swift
////  MoneyTracker
////
////  Created by Olha Bereziuk on 26.06.24.
////
//
//import SwiftUI
//
//struct HorizontalBudgetBoardView: View {
//    
//    // MARK: - State
//    @State private var budgetTextDisplayed = false
//    
//    @Binding var alertPresented: Bool
//    @Binding var detailViewPresented: Bool
//    @Binding var dayBudget: Double
//    @Binding var todayExpenses: Int
//    @Binding var needToUpdateValues: Bool
//    
//    // MARK: - Properties
//    private let infoBoardWidth = Constants.screenWidth / 2.8
//    let budgetAlertText = Constants.budgetTextExplanation
//    
//    // MARK: - Body
//    var body: some View {
//        HStack {
//            self.spentView
//            self.verticalDevider
//            self.budgetView
//        }
//    }
//    
//    // MARK: - Views
//    private var spentView: some View {
//        VStack(spacing: 18) {
//            HStack {
//                Spacer()
//                Text("SPENT")
//                    .font(.customFont(style: .regular, size: .body))
//                    .foregroundStyle(.white)
//            }
//            .padding(.trailing, 30)
//            
//            HStack {
//                Spacer()
//                Text(self.todayExpenses.toString())
//                    .font(.customFont(style: .regular, size: .title))
//                    .foregroundStyle(.white.opacity(0.9))
//                    .contentTransition(.numericText())
//                    .animation(.linear, value: self.todayExpenses)
//            }
//            .padding(.trailing, 22)
//        }
//        .frame(width: self.infoBoardWidth)
//        .onTapGesture {
//            VibrateService.vibrateLight()
//            self.todayExpenses == 0 ? self.alertPresented.toggle() : self.detailViewPresented.toggle()
//            self.needToUpdateValues = false
//        }
//        .sheet(isPresented: self.$detailViewPresented,
//               content: {
//            ExpensesDetailView_old(needToUpdateValues: self.$needToUpdateValues)
//        })
//        .alert("No expenses yet", isPresented: self.$alertPresented) {
//            Button("OK", role: .cancel) {}
//        }
//    }
//    
//    private var verticalDevider: some View {
//        Rectangle()
//            .frame(width: 1, height: 80)
//            .foregroundStyle(.white.opacity(0.3))
//            .padding(.horizontal, 12)
//    }
//    
//    private var budgetView: some View {
//        VStack(spacing: 18) {
//            HStack {
//                Text("BUDGET")
//                    .font(.customFont(style: .regular, size: .body))
//                    .foregroundStyle(.white)
//                Spacer()
//            }
//            .padding(.leading, 30)
//            
//            HStack {
//                Text(String(describing: self.dayBudget).formatAsCurrency())
//                    .font(.customFont(style: .regular, size: .title))
//                    .foregroundStyle(.white.opacity(0.9))
//                    .contentTransition(.numericText())
//                    .animation(.linear, value: self.dayBudget)
//                Spacer()
//            }
//            .padding(.leading, 30)
//        }
//        .frame(width: self.infoBoardWidth)
//        .onTapGesture {
//            VibrateService.vibrateLight()
//            self.budgetTextDisplayed.toggle()
//        }
//        .alert(self.budgetAlertText, isPresented: self.$budgetTextDisplayed) {
//            Button("OK", role: .cancel) {}
//        }
//    }
//}
//
//#Preview {
//    HorizontalBudgetBoardView(
//        alertPresented: .constant(false),
//        detailViewPresented: .constant(false),
//        dayBudget: .constant(0.0), 
//        todayExpenses: .constant(0), 
//        needToUpdateValues: .constant(false)
//    )
//}
