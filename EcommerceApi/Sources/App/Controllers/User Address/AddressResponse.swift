//
//  AddressResponse.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Vapor

struct AddressResponse: Content{
    var country: String?
    var city: String?
    var line1: String?
    var line2: String?
    var house: String?
    var apartment: String?
}
