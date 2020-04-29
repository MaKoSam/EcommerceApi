//
//  RefreshRequest.swift
//  App
//
//  Created by Sam Mazniker on 29/04/2020.
//

import Foundation
import Vapor

struct RefreshRequest: Codable{
    var refreshToken: String
}
