
//
//  AccessibleMenuAnimation.swift
//  Hamburger to Close
//

import SwiftUI

struct AccessibleMenuAnimation: View {
    
    @State private var isRotating = false
    @State private var isHidden = false
    
    // Reduce Motion On
    let subtleFeel = Animation.snappy
    
    // Reduce Motion OFF
    let bouncyFeel = Animation.bouncy(duration: 0.4, extraBounce: 0.2)
    
    // Detect and respond to reduce motion
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    var body: some View {
        VStack(spacing: 14){
            
            Rectangle() // top
                .frame(width: 64, height: 10)
                .cornerRadius(4)
                .rotationEffect(.degrees(isRotating ? 48 : 0), anchor: .leading)
            
            Rectangle() // middle
                .frame(width: 64, height: 10)
                .cornerRadius(4)
                .scaleEffect(isHidden ? 0 : 1, anchor: isHidden ? .trailing: .leading)
                .opacity(isHidden ? 0 : 1)
            
            Rectangle() // bottom
                .frame(width: 64, height: 10)
                .cornerRadius(4)
                .rotationEffect(.degrees(isRotating ? -48 : 0), anchor: .leading)
        }
        // Merge all rectangles into one element
        .accessibilityElement(children: .combine)
        // Set the element's type
        .accessibilityAddTraits(.isButton)
        // Add a short description
        .accessibilityLabel("Menu and close icon transition")
        .onTapGesture {
            withAnimation(reduceMotion ? subtleFeel : bouncyFeel) {
                isRotating.toggle()
                isHidden.toggle()
            }
        }
        
    }
}

#Preview {
    AccessibleMenuAnimation()
        .preferredColorScheme(.dark)
}
