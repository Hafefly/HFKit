//
//  File.swift
//  
//
//  Created by Samy Mehdid on 24/10/2023.
//

import Foundation

internal enum HFRegex: String {
    case email = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    case name = "^[A-Za-z]+([ '-][A-Za-z]+)*$"
    case phone = #"^\d{10}$"#
}
