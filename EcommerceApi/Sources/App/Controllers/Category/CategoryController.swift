//
//  CategoryController.swift
//  App
//
//  Created by Sam Mazniker on 30/04/2020.
//

import Foundation
import Vapor

final class CategoryController {
    func get(_ request: Request) throws -> Future<CategoryResponse> {
        return try request.content.decode(InfoRequest.self).flatMap{ info in
            UserToken.query(on: request).filter(\UserToken.accessToken, .equal, info.accessToken).first().flatMap { result in
                guard let resultToken = result else {
                    throw Abort(.badRequest, reason: "Nonauthorized session")
                }
                let expire = resultToken.expiresAt;
                let now = Int(Date().timeIntervalSince1970)
                if expire < now {
                    throw Abort(.badRequest, reason: "User Access-Token out of date")
                }
                return Categories.query(on: request).all().map{ items in
                    return CategoryResponse(categories: items)
                }
            }
        }
    }
}

