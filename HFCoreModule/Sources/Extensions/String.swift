//
//  File.swift
//  
//
//  Created by Samy Mehdid on 18/10/2023.
//

import Foundation

extension String {
    public var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    public var parseDate: Date? {
        var date: Date?
        let dateFormat = "HH:mm'Z'"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        date = dateFormatter.date(from: self)
        return date
    }
}
