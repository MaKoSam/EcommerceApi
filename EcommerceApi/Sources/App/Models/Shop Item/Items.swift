//
//  Items.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Vapor
import FluentPostgreSQL

final class Items: PostgreSQLModel {
    static let entity = "items"
    
    var id: Int?
    var name: String
    var price: Int
    var description: String?
    var colors: [Colors.ID]
    var sizes: [Sizes.ID]
    var tags: [Categories.ID]
    
    
    init(id: Int? = nil, name: String, price: Int, description: String? = nil, colors: [Colors.ID], sizes: [Sizes.ID], tags: [Categories.ID]){
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.colors = colors
        self.sizes = sizes
        self.tags = tags
    }
    
    static func create(name: String, price: Int) throws -> Items {
        return .init(name: name, price: price, colors: [1,2,3], sizes: [1,2,3], tags: [1,2])
    }
}

extension Items: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.create(Items.self, on: connection){ builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.name)
            builder.field(for: \.price)
            builder.field(for: \.description)
            builder.field(for: \.colors)
            builder.field(for: \.sizes)
            builder.field(for: \.tags)
//            builder.reference(from: \.sizes, to: \[Sizes.ID])
//            builder.reference(from: \.colors, to: \Colors.ID)
//            builder.reference(from: \.tags, to: \Categories.ID)
        }
    }
}
