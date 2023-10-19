//
//  Order.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 15/10/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct OrderReference: CodeIdentifiable {
    @DocumentID public var id: String?
    var userId: String
    var barberId: String
    var createdAt: Timestamp
    var deletedAt: Timestamp?
}

public struct Order: CodeIdentifiable {
    @DocumentID public var id: String?
    
    var userId: String
    var barberId: String
    
    public var fade: UInt?
    public var beard: UInt?
    public var hairdryer: UInt?
    public var razor: UInt?
    public var scissors: UInt?
    public var straightener: UInt?
    public var atHome: UInt?
    
    public var totalPrice: UInt
    
    var intervals: [OrderInterval]?
    public var confirmedInterval: OrderInterval?
    
    public init(userId: String, barberId: String, fade: UInt?, beard: UInt?, hairdryer: UInt?, razor: UInt?, scissors: UInt?, straightener: UInt?, atHome: UInt?, totalPrice: UInt, intervals: [OrderInterval]? = nil, confirmedInterval: OrderInterval? = nil) {
        self.userId = userId
        self.barberId = barberId
        self.fade = fade
        self.beard = beard
        self.hairdryer = hairdryer
        self.razor = razor
        self.scissors = scissors
        self.straightener = straightener
        self.atHome = atHome
        self.totalPrice = totalPrice
        self.intervals = intervals
        self.confirmedInterval = confirmedInterval
    }
    
    static let mockOrders = [
        Order(userId: "", barberId: "", fade: 150, beard: 100, hairdryer: nil, razor: nil, scissors: 50, straightener: nil, atHome: 150, totalPrice: 450, confirmedInterval: OrderInterval(from: Timestamp(), to: Timestamp())),
        Order(userId: "", barberId: "", fade: 150, beard: 100, hairdryer: nil, razor: nil, scissors: 50, straightener: nil, atHome: 150, totalPrice: 450, confirmedInterval: OrderInterval(from: Timestamp(), to: Timestamp())),
        Order(userId: "", barberId: "", fade: 150, beard: 100, hairdryer: nil, razor: nil, scissors: 50, straightener: nil, atHome: 150, totalPrice: 450, confirmedInterval: OrderInterval(from: Timestamp(), to: Timestamp())),
        Order(userId: "", barberId: "", fade: 150, beard: 100, hairdryer: nil, razor: nil, scissors: 50, straightener: nil, atHome: 150, totalPrice: 450, confirmedInterval: OrderInterval(from: Timestamp(), to: Timestamp()))
    ]
}

public struct OrderInterval: Codable {
    var from: Timestamp
    var to: Timestamp
    
    var timeString: String {
        return "\(from.dateValue().getFormattedHour()) - \(to.dateValue().getFormattedDate())"
    }
}
