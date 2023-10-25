//
//  File.swift
//  
//
//  Created by Samy Mehdid on 19/10/2023.
//

import Foundation

extension String {
    func regexChecker(with regex: HFRegex) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex.rawValue)
            let range = NSRange(location: 0, length: self.utf16.count)
            let matches = regex.matches(in: self, options: [], range: range)
            
            return !matches.isEmpty
        } catch {
            return false
        }
    }
}
