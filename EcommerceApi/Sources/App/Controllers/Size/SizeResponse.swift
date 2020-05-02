//
//  SizeResponse.swift
//  App
//
//  Created by Sam Mazniker on 30/04/2020.
//

import Foundation
import Vapor

struct SizeResponse: Content {
    var sizes: [Sizes]
}
