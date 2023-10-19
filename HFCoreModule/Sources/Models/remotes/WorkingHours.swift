//
//  WorkingHours.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 13/10/2023.
//

import Foundation

public struct WorkingHours: Codable {
    let opening: String
    let closing: String
    
    var openingDate: Date {
        return opening.parseDate ?? Date()
    }
    
    var closingDate: Date {
        return closing.parseDate ?? Date()
    }
}
