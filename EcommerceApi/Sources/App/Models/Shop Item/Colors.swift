//
//  Colors.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Vapor
import FluentPostgreSQL

final class Colors: PostgreSQLModel {
    static let entity = "item_colors"
    
    var id: Int?
    var name: String
    
    init(id: Int? = nil, name: String){
        self.id = id
        self.name = name
    }
    
    static func configurate() throws -> [Colors] {
        var array = [Colors]()
        array.append(.init(name: "white"))
        array.append(.init(name: "black"))
        array.append(.init(name: "green"))
        array.append(.init(name: "yellow"))
        array.append(.init(name: "red"))
        return array
    }
}

extension Colors: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.create(Colors.self, on: connection){ builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.name)
        }
    }
}
