//
//  AddRequest.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Foundation
import Vapor

struct AddRequest: Codable {
    var adminPassword: String
    var name: String
    var price: Int
}
