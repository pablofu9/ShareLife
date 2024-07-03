//
//  Spending.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 3/7/24.
//

import Foundation
import SwiftUI
import RealmSwift

enum SpendingType: String {
    case restaurants = "Restaurant"
    case freeTime = "Free Time"
    case transport = "Transport"
    case feeding = "Fedding"
    case pets = "Pets"
    case shopping = "Shopping"
    case health = "Health"
    case gifts = "Gifts"
    case home = "Home"
    
    var image: String {
        switch self {
        case .restaurants:
            return "fork.knife"
        case .freeTime:
            return "film"
        case .transport:
            return "car"
        case .feeding:
            return "basket"
        case .pets:
            return "pawprint"
        case .shopping:
            return "creditcard"
        case .health:
            return "bandage"
        case .gifts:
            return "gift"
        case .home:
            return "house"
        }
    }
    
    var color: Color {
        switch self {
        case .restaurants:
            return Color.restaurantColor
        case .freeTime:
            return Color.freeTimeColor
        case .transport:
            return Color.transportColor
        case .feeding:
            return Color.feedingColor
        case .pets:
            return Color.petsColor
        case .shopping:
            return Color.shoppingColor
        case .health:
            return Color.healthColor
        case .gifts:
            return Color.giftColor
        case .home:
            return Color.homeColor
        }
    }
}


class RealmSpending: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var category: String = ""
    @Persisted var amount: Double = 0.0
    
    convenience init(name: String = "", category: String = "", amount: Double = 0.0) {
        self.init()
        self.name = name
        self.category = category
        self.amount = amount
    }

}

extension RealmSpending {
    static var mock: [RealmSpending] {
        [
            RealmSpending(name: "Seguro de coche", category: "Transport", amount: 350)
        ]
    }
}

