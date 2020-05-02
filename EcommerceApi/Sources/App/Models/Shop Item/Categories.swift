//
//  Categories.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Vapor
import FluentPostgreSQL

final class Categories: PostgreSQLModel {
    static let entity = "item_categories"
    
    var id: Int?
    var name: String
    
    init(id: Int? = nil, name: String){
        self.id = id
        self.name = name
    }
    
    static func configurate() throws -> [Categories] {
        var array = [Categories]()
        array.append(.init(name: "New"))
        array.append(.init(name: "Men"))
        array.append(.init(name: "Women"))
        return array
    }
}

extension Categories: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.create(Categories.self, on: connection){ builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.name)
        }
    }
}

