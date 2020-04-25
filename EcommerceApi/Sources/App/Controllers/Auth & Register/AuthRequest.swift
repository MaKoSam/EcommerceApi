//
//  AuthRequest.swift
//  App
//
//  Created by Sam Mazniker on 24/04/2020.
//

import Foundation
import Vapor

struct AuthRequest: Codable {
    var username: String
    var password: String
}

