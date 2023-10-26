//
//  File.swift
//  
//
//  Created by Samy Mehdid on 25/10/2023.
//

import Foundation

enum OTPFieldUiState: Equatable {
    case hidden
    case displayed
    case loading
    case success
    
    var opacity: Double {
        return self == .hidden ? 0 : 1
    }
}
