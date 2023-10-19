//
//  HFButton.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 12/10/2023.
//

import SwiftUI

public struct HFButtonStyle: ButtonStyle {
    
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack{
            Spacer()
            configuration.label
            Spacer()
        }
        .padding(.vertical, 12)
        .background(Color("HFOrange"))
        .cornerRadius(12)
    }
}
