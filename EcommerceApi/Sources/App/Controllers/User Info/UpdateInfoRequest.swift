//
//  UpdateInfoRequest.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Vapor

struct UpdateInfoRequest: Codable {
    var name: String
    var email: String
    var phone: String
    var accessToken: String
}
