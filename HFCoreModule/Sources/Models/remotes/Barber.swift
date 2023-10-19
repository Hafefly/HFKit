//
//  HFBarber.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 13/10/2023.
//

import Foundation
import FirebaseFirestoreSwift

public struct Barber: CodeIdentifiable {
    
    @DocumentID public var id: String?
    var barbershopUID: String?
    var barbershopName: String?
    var profileImage: String?
    var firstname: String
    var lastname: String
    var email: String
    var bio: String?
    var age: UInt?
    var experience: UInt
    var haircutsDone: UInt
    var instagram: String?
    var isAvailableToHome: Bool
    var phoneNumber: String?
    var province: String?
    var rating: Double?
    var verified: Bool
    var workingHours: WorkingHours?
    
    public init(
        barbershopUID: String? = nil,
        barbershopName: String? = nil,
        profileImage: String? = nil,
        firstname: String,
        lastname: String,
        email: String,
        bio: String? = nil,
        age: UInt? = nil,
        experience: UInt = 0,
        haircutsDone: UInt = 0,
        instagram: String? = nil,
        isAvailableToHome: Bool = false,
        phoneNumber: String? = nil,
        province: String? = nil,
        rating: Double? = nil,
        verified: Bool = false,
        workingHours: WorkingHours? = nil) {
            self.barbershopUID = barbershopUID
            self.barbershopName = barbershopName
            self.profileImage = profileImage
            self.firstname = firstname
            self.lastname = lastname
            self.email = email
            self.bio = bio
            self.age = age
            self.experience = experience
            self.haircutsDone = haircutsDone
            self.instagram = instagram
            self.isAvailableToHome = isAvailableToHome
            self.phoneNumber = phoneNumber
            self.province = province
            self.rating = rating
            self.verified = verified
            self.workingHours = workingHours
        }
}
