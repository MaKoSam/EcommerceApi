//
//  GetResponse.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Foundation
import Vapor

struct GetResponse: Content {
    var items: [Items]
}
