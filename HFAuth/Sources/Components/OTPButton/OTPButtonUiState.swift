//
//  File.swift
//  
//
//  Created by Samy Mehdid on 26/10/2023.
//

import SwiftUI

enum OTPButtonUiState: Equatable {
    case disabled(Int)
    case valid(Int)
    case success
    
    var backgroundColor: Color {
        switch self {
        case .disabled:
            return .gray
        case .valid:
            return .hfOrange
        case .success:
            return .green
        }
    }
    
    var text: String {
        switch self {
        case .disabled(let count), .valid(let count):
            return count > 0 ? "resend otp" : "send otp"
        case .success:
            return "done"
        }
    }
    
    var disabled: Bool {
        if case .valid = self {
            return false
        }
        
        return true
    }
}
