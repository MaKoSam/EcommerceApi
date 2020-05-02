//
//  RegisterUserRequest.swift
//  App
//
//  Created by Sam Mazniker on 24/04/2020.
//

import Foundation
import Vapor

struct RegisterUserRequest: Codable {
    var username: String
    var password: String
    var email: String
}

