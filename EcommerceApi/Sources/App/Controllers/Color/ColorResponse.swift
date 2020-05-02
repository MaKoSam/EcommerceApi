//
//  ColorResponse.swift
//  App
//
//  Created by Sam Mazniker on 30/04/2020.
//

import Foundation
import Vapor

struct ColorResponse: Content {
    var colors: [Colors]
}
