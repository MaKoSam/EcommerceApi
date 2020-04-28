//
//  GetRequest.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Foundation
import Vapor

struct GetRequest: Codable {
    var page: Int?
    var accessToken: String
}
