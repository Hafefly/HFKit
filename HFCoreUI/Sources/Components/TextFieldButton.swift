//
//  TextFieldButton.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 17/10/2023.
//

import SwiftUI

public struct TextFieldButton<Label: View>: View {
    var label: () -> Label
    
    private var textField = Weak<UITextField>(nil)
    
    public init(label: @escaping () -> Label) {
        self.label = label
    }
    
    public var body: some View {
        Button(action: {
            self.textField.value?.becomeFirstResponder()
        }, label: {
            label()
        }).buttonStyle(PlainButtonStyle())
    }
}
