//
//  HFAuthTextField.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 12/10/2023.
//

import SwiftUI

public struct HFTextFieldStyle: TextFieldStyle {
    
    var uiState: UiState<String>
    
    public init(_ uiState: UiState<String>) {
        self.uiState = uiState
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        switch uiState {
        case .idle:
            configBuilder(configuration) { EmptyView() }
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.white, lineWidth: 3)
                )
        case .loading:
            configBuilder(configuration) {
                LoadingView()
            }
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.white, lineWidth: 3)
                )
        case .success(let message):
            VStack(alignment: .leading) {
                configBuilder(configuration){
                    Image("ic_check_white")
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.green, lineWidth: 3)
                )
                Text(message)
                    .font(.green, .medium, 14)
            }
        case .failed(let message):
            VStack(alignment: .leading){
                configBuilder(configuration) {
                    Image("ic_close_white")
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.red, lineWidth: 3)
                )
                Text(message)
                    .font(.red, .medium, 14)
            }
        }
    }
    
    @ViewBuilder
    private func configBuilder(_ configuration: TextField<Self._Label>, icon: (() -> some View)? = nil) -> some View {
        HStack{
            configuration
            if let icon = icon {
                Spacer()
                icon()
                    .frame(width: 24, height: 24)
            }
        }
        .foregroundColor(Color.white)
        .padding()
        .background(Color.primaryColor)
        .cornerRadius(12)
    }
}
