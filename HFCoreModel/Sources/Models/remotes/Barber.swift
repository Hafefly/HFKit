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
    public var barbershopUID: String?
    public var barbershopName: String?
    public var profileImage: String?
    public var fullname: String
    public var email: String
    public var bio: String?
    public var age: UInt?
    public var experience: UInt
    public var haircutsDone: UInt
    public var instagram: String?
    public var isAvailableToHome: Bool
    public var phoneNumber: String?
    public var province: String?
    public var rating: Double?
    public var verified: Bool
    public var workingHours: WorkingHours?
    
    public init(
        barbershopUID: String? = nil,
        barbershopName: String? = nil,
        profileImage: String? = nil,
        fullname: String,
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
            self.fullname = fullname
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
