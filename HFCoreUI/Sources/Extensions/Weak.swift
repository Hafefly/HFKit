//
//  File.swift
//  
//
//  Created by Samy Mehdid on 18/10/2023.
//

import Foundation

class Weak<T: AnyObject> {
    public weak var value: T?
    public init(_ value: T?) {
        self.value = value
    }
}
