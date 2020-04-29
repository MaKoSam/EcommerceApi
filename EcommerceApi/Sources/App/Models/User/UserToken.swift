//
//  UserToken.swift
//  App
//
//  Created by Sam Mazniker on 23/04/2020.
//

import Vapor
import FluentPostgreSQL
import Authentication
import Crypto

final class UserToken: PostgreSQLModel {
    static let entity = "users_token"
    
    var id: Int?
    var accessToken: String
    var refreshToken: String
    var expiresAt: Int
    var userID: Users.ID
    
    var users: Parent<UserToken, Users> {
        return parent(\.userID)
    }
    
    init(id: Int? = nil, accessToken: String, refreshToken: String, userID: Users.ID){
        self.id = id
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.userID = userID
        self.expiresAt = Int(Date().timeIntervalSince1970) + 24 * 60 * 60
    }
    
    static func create(userID: Users.ID) throws -> UserToken {
        let accessToken = try CryptoRandom().generateData(count: 16).base64EncodedString()
        let refreshToken = try CryptoRandom().generateData(count: 16).base64EncodedString()
        return .init(accessToken: accessToken, refreshToken: refreshToken, userID: userID)
    }
    
    static func refresh(token: UserToken) throws -> UserToken {
        token.accessToken = try CryptoRandom().generateData(count: 16).base64EncodedString()
        token.expiresAt = Int(Date().timeIntervalSince1970) + 24 * 60 * 60
        return token
    }
}

extension Users: TokenAuthenticatable {
    typealias TokenType = UserToken
}

extension UserToken: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.create(UserToken.self, on: connection){ builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.accessToken)
            builder.field(for: \.refreshToken)
            builder.field(for: \.expiresAt)
            builder.field(for: \.userID)
            builder.reference(from: \.userID, to: \Users.id)
        }
    }
}

extension UserToken: Token {
    typealias UserIDType = Users.ID
    typealias UserType = Users
    
    static var tokenKey: WritableKeyPath<UserToken, String> {
        return \.accessToken
    }
    
    static var userIDKey: WritableKeyPath<UserToken, Users.ID> {
        return \.userID
    }
}
