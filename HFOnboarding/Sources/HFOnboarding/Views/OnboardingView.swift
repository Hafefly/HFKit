//
//  SwiftUIView.swift
//  
//
//  Created by Samy Mehdid on 2/11/2023.
//

import SwiftUI

internal struct OnboardingView: View {
    
    @StateObject private var model = Model()
    
    let success: () -> Void
    
    internal init(success: @escaping () -> Void) {
        self.success = success
    }
    
    var body: some View {
        VStack{
            switch model.pageState {
            case .first:
                Text("1")
            case .second:
                Text("2")
            case .third:
                Text("3")
            }
            
            
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView {
            
        }
    }
}
