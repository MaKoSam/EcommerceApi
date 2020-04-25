//
//  Users.swift
//  App
//
//  Created by Sam Mazniker on 23/04/2020.
//

import Vapor
import FluentPostgreSQL

final class Users: PostgreSQLModel, Hashable {
    static let entity = "users"
    
    var id: Int? = nil
    var username: String
    var email: String
    var passwordHash: String
    
    init(id: Int? = nil, username: String, email: String, passwordHash: String){
        self.id = id
        self.username = username
        self.email = email
        self.passwordHash = passwordHash
    }
    
    static func == (lhs: Users, rhs: Users) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey{
        case id
        case username
        case email
        case passwordHash = "password_hash"
    }
}

extension Users: Parameter {
    
}

extension Users: Content {
    
}

extension Users: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.create(Users.self, on: connection) {
            builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.email)
            builder.field(for: \.passwordHash)
            builder.field(for: \.username, type: .varchar, .unique())
        }
    }
}
