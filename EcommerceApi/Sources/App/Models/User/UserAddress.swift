//
//  UserAddress.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class UserAddress: PostgreSQLModel {
    static let entity: String = "UserAddress"
    
    var id: Int?
    var userID: Users.ID
    var country: String?
    var city: String?
    var line1: String?
    var line2: String?
    var house: String?
    var apartment: String?
    
    init(id: Int? = nil, userID: Users.ID, country: String? = nil, city: String? = nil, line1: String? = nil, line2: String? = nil, house: String? = nil, apartment: String? = nil){
        self.id = id
        self.userID = userID
        self.country = country
        self.city = city
        self.line1 = line1
        self.line2 = line2
        self.house = house
        self.apartment = apartment
    }
    
    static func create(for userID: Users.ID, email: String? = nil) throws -> UserAddress {
        let country = "Страна"
        let city = "Город"
        let line1 = "Улица"
        let line2 = ""
        let house = "Дом"
        let apartment = "Квартира"
        return .init(userID: userID, country: country, city: city, line1: line1, line2: line2, house: house, apartment: apartment)
    }
}

extension UserAddress: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.create(UserAddress.self, on: connection){ builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.country)
            builder.field(for: \.city)
            builder.field(for: \.line1)
            builder.field(for: \.line2)
            builder.field(for: \.house)
            builder.field(for: \.apartment)
            builder.field(for: \.userID)
            builder.reference(from: \.userID, to: \Users.id)
        }
    }
}

