//
//  ContentView.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 15.03.24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @StateObject var viewModel = HomeViewModel()
    @State private var isSplashActive: Bool = true
    @State private var selectedTab = 0
    @State private var isNewRecordPresented = false
    
    var body: some View {
        ZStack {
            
            if isSplashActive {
                SplashScreenView(isSplashActive: $isSplashActive)
                
            } else {
                if isFirstLaunch {
                    OnboardingView(isFirstLaunch: $isFirstLaunch)
                } else {
                    ZStack(alignment: .bottom) {
                        TabView(selection: $selectedTab) {
                            // Using TabItems inside a LazyView if needed
                            LazyView(TabItems(homeViewModel: self.viewModel))
                        }
                        .accentColor(.pink)
                        
                        // Big custom center button
                        Button(action: {
                            VibrateService.vibrateMedium()
                            self.isNewRecordPresented.toggle()
                            print("Custom button tapped")
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                    }
                }
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
}
    
    #Preview {
        return ContentView()
    }
