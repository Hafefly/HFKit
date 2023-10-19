//
//  UiState.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 13/10/2023.
//

import Foundation

public enum UiState<Model> {
    case idle
    case loading
    case success(Model)
    case failed(String)

    public var data: Model? {
        if case let .success(a) = self {
            return a
        } else {
            return nil
        }
    }
}
