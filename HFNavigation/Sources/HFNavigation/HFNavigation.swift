// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public class ArbinNavigation {
    private init() {}
    
    public static func setConfig(startPoint: any View) {
        NavigationCoordinator.shared.setStartPoint(startPoint)
    }
}
