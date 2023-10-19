//
//  LoadingView.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 17/10/2023.
//

import SwiftUI

struct LoadingView: View {
    
    private let gradient: AngularGradient
    private let animation: Animation
    private let color: Color
    private let lineWidth: CGFloat
    private let trim: CGFloat
    
    @State private var angle = 0.0
    
    init(color: Color = .white, lineWidth: CGFloat = 2, trim: CGFloat = 0.75) {
        self.color = color
        self.lineWidth = lineWidth
        self.trim = trim
        gradient = AngularGradient(
            gradient: Gradient(colors: [color, color.opacity(0)]),
            center: .center,
            startAngle: .degrees(270),
            endAngle: .degrees(0)
        )
        animation = Animation
            .linear(duration: 0.6)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: trim)
            .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .rotationEffect(Angle(degrees: angle))
            .foregroundColor(color)
            .animation(animation, value: angle)
            .onAppear {
                DispatchQueue.main.async {
                    angle = 360.0
                }
            }
    }
}

struct LoadingViewGradient: View {
    private let gradient: AngularGradient
    private let lineWidth: CGFloat
    private let trim: CGFloat
    private let animation: Animation
    @State private var angle = 0.0
       
    init(
        startColor: Color,
        endColor: Color = .white,
        lineWidth: CGFloat = 6.0,
        trim: CGFloat = 0.75
    ) {
        self.lineWidth = lineWidth
        self.trim = trim
        gradient = AngularGradient(
            gradient: Gradient(colors: [startColor, endColor]),
            center: .center,
            startAngle: .degrees(270),
            endAngle: .degrees(0)
        )
        
        animation = Animation
            .linear(duration: 1)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Circle()
            .trim(from: 0, to: trim)
            .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .rotationEffect(Angle(degrees: angle))
            .animation(animation, value: angle)
            .onAppear {
                DispatchQueue.main.async {
                    angle = 360.0
                }
            }
    }
}
