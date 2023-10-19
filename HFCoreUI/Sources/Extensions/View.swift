//
//  File.swift
//  
//
//  Created by Samy Mehdid on 18/10/2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    public func ImagePattern() -> some View {
        self.overlay(
            Image("pattern")
                .resizable()
                .scaledToFill()
                .opacity(0.06)
        )
    }
    
    func titlePattern() -> some View {
        self.overlay(
            Image("pattern")
                .resizable()
                .scaledToFill()
                .opacity(0.1)
        )
    }
    
    public func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
