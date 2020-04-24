//
//  AuthResponse.swift
//  App
//
//  Created by Sam Mazniker on 24/04/2020.
//

import Foundation
import Vapor

struct AuthResponse: Content{
    var accessToken: String
    var refreshToken: String
    var expires: Int? = nil
}

