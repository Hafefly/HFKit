//
//  File.swift
//  
//
//  Created by Samy Mehdid on 2/11/2023.
//

import Foundation

extension OnboardingView {
    internal class Model: ObservableObject {
        
        @Published internal private(set) var pageState: PageState = .first
        
        internal func nextPage(success: @escaping () -> Void) {
            guard pageState != .third else {
                success()
                return
            }
            
            self.pageState = self.pageState.nextPage()
        }
    }
}
