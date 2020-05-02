//
//  UserInfo.swift
//  App
//
//  Created by Sam Mazniker on 24/04/2020.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class UserInfo: PostgreSQLModel {
    static let entity: String = "UserInfo"
    
    var id: Int?
    var userID: Users.ID
    var name: String?
    var email: String?
    var phone: String?
    
    init(id: Int? = nil, userID: Users.ID, name: String? = nil, email: String? = nil, phone: String? = nil){
        self.id = id
        self.userID = userID
        self.name = name
        self.email = email
        self.phone = phone
    }
    
    static func create(for userID: Users.ID, email: String? = nil) throws -> UserInfo {
        let name = "Гость"
        let phone = ""
        return .init(userID: userID, name: name, email: email, phone: phone)
    }
}

extension UserInfo: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.create(UserInfo.self, on: connection){ builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.name)
            builder.field(for: \.email)
            builder.field(for: \.phone)
            builder.field(for: \.userID)
            builder.reference(from: \.userID, to: \Users.id)
        }
    }
}

