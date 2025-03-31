//
//  SettingsDetailedListView.swift
//  MoneyTracker
//
//  Created by Olha Bereziuk on 02.12.24.
//

import SwiftUI

struct SettingsDetailedListView<T: PickerItem & Hashable>: View {
    
    // MARK: - States
    @Binding var selectedValue: T
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Properties
    let items: [T]
    
    // MARK: - Init
    init(
        items: [T],
        selectedValue: Binding<T>
    ) {
        self.items = items.sorted { $0.rawValue < $1.rawValue }
        self._selectedValue = selectedValue
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.background)
                .ignoresSafeArea()
            
            List {
                ForEach(self.items) { item in
                    self.makeCell(item: item)
                        .listRowBackground(Color(uiColor: UIColor.secondarySystemBackground))
                }
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .padding(.bottom, -36)
            .padding(.horizontal, 24)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    VibrateService.vibrateMedium()
                    dismiss()
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .foregroundStyle(Color(hex: "E3E3E5")) // TODO: - make Colour constants
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Views
    private func makeCell(item: T) -> some View {
        HStack {
            Text(item.rawValue)
                .font(.system(size: 16, weight: .medium, design: .default))
            Spacer()
            
            if item == self.selectedValue {
                Image(systemName: "checkmark")
                    .foregroundStyle(.pink)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            VibrateService.vibrateMedium()
            self.selectedValue = item
        }
    }
}

#Preview {
    SettingsDetailedListView(
        items: Country.allCases,
        selectedValue: .constant(Country(rawValue: "Ukraine") ?? .germany)
    )
}
