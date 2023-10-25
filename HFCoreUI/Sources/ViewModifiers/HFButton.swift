//
//  HFButton.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 12/10/2023.
//

import SwiftUI

public struct HFButtonStyle: ButtonStyle {
    
    private var disabled: Bool
    
    public init(disabled: Bool) {
        self.disabled = disabled
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack{
            Spacer()
            configuration.label
            Spacer()
        }
        .frame(height: 56)
        .background(disabled ? Color.gray : Color.hfOrange)
        .cornerRadius(12)
        .disabled(disabled)
    }
}
