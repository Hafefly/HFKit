//
//  File.swift
//  
//
//  Created by Samy Mehdid on 19/10/2023.
//

import Foundation
import FirebaseAuth

public struct HFUser {
    var id: String?
    var profileImage: String?
    var firstname: String
    var lastname: String
    var email: String
    var phoneNumber: String?
    
    init(user: User) {
        self.id = user.uid
        self.profileImage = user.photoURL?.absoluteString
        self.firstname = user.displayName ?? ""
        self.lastname = user.displayName ?? ""
        self.email = user.email ?? ""
        self.phoneNumber = user.phoneNumber ?? ""
    }
}
