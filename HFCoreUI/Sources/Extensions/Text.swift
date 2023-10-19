//
//  Text.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 12/10/2023.
//

import SwiftUI

extension Text {
    public func font(_ color: Color,_ font: Font.SFProRounded, _ size: CGFloat) -> Text {
        switch font {
        case .regular:
            return self
                .font(.custom(Font.SFProRounded.regular.rawValue, size: size))
                .foregroundColor(color)
        case .medium:
            return self
                .font(.custom(Font.SFProRounded.medium.rawValue, size: size))
                .foregroundColor(color)
        case .semiBold:
            return self
                .font(.custom(Font.SFProRounded.semiBold.rawValue, size: size))
                .foregroundColor(color)
        case .bold:
            return self
                .font(.custom(Font.SFProRounded.bold.rawValue, size: size))
                .foregroundColor(color)
        }
    }
    
    public func title() -> Text {
        return self
            .font(.custom(Font.HFImpact.regular.rawValue, size: 32))
            .foregroundColor(.white)
    }
}
