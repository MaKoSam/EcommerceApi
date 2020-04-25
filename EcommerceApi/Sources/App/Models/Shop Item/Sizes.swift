//
//  Sizes.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Vapor
import FluentPostgreSQL

final class Sizes: PostgreSQLModel {
    static let entity = "item_sizes"
    
    var id: Int?
    var name: String
    
    init(id: Int? = nil, name: String){
        self.id = id
        self.name = name
    }
    
    static func configurate() throws -> [Sizes] {
        var array = [Sizes]()
        array.append(.init(name: "XS"))
        array.append(.init(name: "S"))
        array.append(.init(name: "M"))
        array.append(.init(name: "L"))
        array.append(.init(name: "XL"))
        return array
    }
}

extension Sizes: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.create(Sizes.self, on: connection){ builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.name)
        }
    }
}
