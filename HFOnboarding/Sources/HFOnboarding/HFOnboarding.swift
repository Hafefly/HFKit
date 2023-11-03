// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import HFNavigation

public class HFOnboarding {
    
    init(success: @escaping () -> Void) {
        NavigationCoordinator.pushScreen(OnboardingView(success: success))
    }
}
