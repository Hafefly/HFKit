//
//  File.swift
//  
//
//  Created by Samy Mehdid on 2/11/2023.
//

import Foundation

internal enum PageState {
    case first
    case second
    case third
    
    func nextPage() -> Self {
        switch self {
        case .first:
            return .second
        case .second:
            return .third
        case .third:
            return .third
        }
    }
}
