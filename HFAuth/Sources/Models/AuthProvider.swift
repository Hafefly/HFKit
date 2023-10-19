//
//  AuthProvider.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 12/10/2023.
//

import SwiftUI

enum AuthProvider: String, CaseIterable {
    case facebook
    case google
    case apple
    
    var icon: Image {
        return Image("ic_\(self.rawValue)_white")
    }
}
