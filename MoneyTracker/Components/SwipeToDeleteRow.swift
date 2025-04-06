//
//  SwipeToDeleteRow.swift
//  Monika
//
//  Created by Olha Bereziuk on 06.04.25.
//

import SwiftUI

struct SwipeToDeleteRow<Content: View>: View {
    
    let content: () -> Content
    let onDelete: () -> Void
    
    @State private var offsetX: CGFloat = 0
    @State private var isSwiped: Bool = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // Background Delete Button
            RoundedRectangle(cornerRadius: 20)
                .fill(.red)
                .padding(1)
            
            Button(action: {
                withAnimation {
                    onDelete()
                }
            }) {
                Image(systemName: "xmark.bin.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.trailing, 24)
            }
            
            // Your custom cell content
            content()
                .background(Color.clear)
                .offset(x: offsetX)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            // Allow swiping left only
                            if gesture.translation.width < 0 {
                                offsetX = gesture.translation.width
                            }
                        }
                        .onEnded { gesture in
                            if gesture.translation.width < -80 {
                                // If swiped far enough, leave the cell partially off-screen to reveal Delete
                                withAnimation {
                                    offsetX = -100
                                    isSwiped = true
                                }
                            } else {
                                // Otherwise, snap back to original position
                                withAnimation {
                                    offsetX = 0
                                    isSwiped = false
                                }
                            }
                        }
                )
                .onTapGesture {
                    // If cell is swiped open, tap to close it
                    if isSwiped {
                        withAnimation {
                            offsetX = 0
                            isSwiped = false
                        }
                    }
                }
        }
    }
}
