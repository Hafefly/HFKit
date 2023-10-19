//
//  Date.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 15/10/2023.
//

import Foundation

extension Date {
    func getFormattedHour(format: String = "HH:mm") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func getFormattedDate(format: String = "dd/MM/yyyy") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
