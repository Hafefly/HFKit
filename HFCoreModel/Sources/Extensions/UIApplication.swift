//
//  File.swift
//
//
//  Created by Samy Mehdid on 18/10/2023.
//

import UIKit

extension UIApplication {
    public static func call(phoneCode: String = "213", phone: String) {
        guard let url = URL(string: "tel://+\(phoneCode)\(phone)") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    public static func endEditing() {
        shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
