//
//  CategoryResponse.swift
//  App
//
//  Created by Sam Mazniker on 30/04/2020.
//

import Foundation
import Vapor

struct CategoryResponse: Content {
    var categories: [Categories]
}
