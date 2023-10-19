//
//  File.swift
//  
//
//  Created by Samy Mehdid on 27/9/2023.
//

import SwiftUI

public extension View {
    func popBack(count: Int = 1, home: Bool = false) {
        NavigationCoordinator.popBack(count: count, home: home)
    }

    func pushScreen(_ screen: any View, withAnimation animation: TransitAnimation = .opacity) {
        NavigationCoordinator.pushScreen(screen)
    }
    
    func pushPopup(_ popup: any View, withAnimation animation: TransitAnimation = .fromBottom) {
        NavigationCoordinator.pushPopup(popup)
    }
    
    func popupBackground() -> some View {
        self.background(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.3), .black.opacity(0.3), .black.opacity(0.3), .black.opacity(0.3), .black.opacity(0.3), .black.opacity(0.3), .black.opacity(0.3), .black.opacity(0.3),  .black.opacity(0.2), .black.opacity(0.1), .clear]), startPoint: .bottom, endPoint: .top).ignoresSafeArea().onTapGesture {
            popBack()
        })
    }
}

extension View {
    public func setupDefaultBackHandler(home: Bool = false) -> some View {
        self.modifier(BackHandlerModifier(popToHome: home, handler: nil))
    }
    
    public func setupBackHandler(_ handler: NavigationBackHandler) -> some View {
        self.modifier(BackHandlerModifier(popToHome: false, handler: handler))
    }
}

public struct BackHandlerModifier: ViewModifier, NavigationBackHandler {
    public let popToHome: Bool
    public let handler: NavigationBackHandler?
    
    public func popScreenDueToSwipe() {
        NavigationCoordinator.popBack(home: popToHome)
    }
    
    @EnvironmentObject private var screenInfo: ScreenInfo
    
    public func body(content: Content) -> some View {
       content
            .onAppear {
                screenInfo.backHandler = handler ?? self
            }
    }
}
