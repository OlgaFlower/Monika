//
//  TabItems.swift
//  Savvvy
//
//  Created by Olha Bereziuk on 15.12.24.
//

import SwiftUI

struct TabItems: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        Group {
            NavigationStack {
                HomeView(viewModel: self.homeViewModel)
            }
            .tabItem {
                Label(
                    title: {},
                    icon: {
                        Image("expenses")
                            .renderingMode(.template)
                    }
                )
            }
            .tag(0)
            
            // Centered Big Plus button
            NavigationStack {
                // it keeps place for a big Plus button in the tab bar
            }
            .tabItem {
                Label(
                    title: {},
                    icon: {}
                )
            }
            .tag(1)
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label(
                    title: {},
                    icon: {
                        Image("settings")
                            .renderingMode(.template)
                    }
                )
            }
            .tag(2)
        }
    }
}
