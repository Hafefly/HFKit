//
//  HFUser.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 16/10/2023.
//

import Foundation
import FirebaseFirestoreSwift

public struct Client: CodeIdentifiable {
    @DocumentID public var id: String?
    
    var firstname: String
    var lastname: String
    var profileImage: String?
    var phone: String?
    var email: String?
    var instagram: String?
    var province: String
    var haircutsDone: UInt
    var age: UInt
    var vip: Bool
    
    public init(firstname: String, lastname: String, profileImage: String? = nil, phone: String? = nil, email: String? = nil, instagram: String? = nil, province: String, haircutsDone: UInt, age: UInt, vip: Bool) {
        self.firstname = firstname
        self.lastname = lastname
        self.profileImage = profileImage
        self.phone = phone
        self.email = email
        self.instagram = instagram
        self.province = province
        self.haircutsDone = haircutsDone
        self.age = age
        self.vip = vip
    }
}
