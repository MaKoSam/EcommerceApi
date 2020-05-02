//
//  InfoResponse.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Vapor

struct InfoResponse: Content {
    var name: String?
    var email: String?
    var phone: String?
}
