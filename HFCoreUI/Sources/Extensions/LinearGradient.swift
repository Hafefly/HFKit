//
//  File.swift
//  
//
//  Created by Samy Mehdid on 18/10/2023.
//

import SwiftUI

extension LinearGradient {
    public static let hfGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .clear, location: 0.00),
            Gradient.Stop(color: .primaryColor, location: 0.67),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
}
