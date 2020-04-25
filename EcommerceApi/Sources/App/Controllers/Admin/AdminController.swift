//
//  AdminController.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//
// Только для тестов на домашней сети

import Foundation
import Vapor

final class AdminController {
    func config(_ request: Request) throws -> ConfigResponse {
        let sizes = try Sizes.configurate()
        let categories = try Categories.configurate()
        let colors = try Colors.configurate()
        
        for size in sizes {
            let _ = size.save(on: request)
        }
        
        for color in colors {
            let _ = color.save(on: request)
        }
        
        for category in categories {
            let _ = category.save(on: request)
        }
        
        return ConfigResponse(configurated: true)
    }
    
    func addItem(_ request: Request) throws -> Future<AddResponse> {
        return try request.content.decode(AddRequest.self).flatMap{ addItem in
            let newItem = try Items.create(name: addItem.name, price: addItem.price)
            return newItem.save(on: request).map { saved in
                return AddResponse(success: true)
            }
        }
    }
}
