//
//  UserAddressController.swift
//  App
//
//  Created by Sam Mazniker on 25/04/2020.
//

import Foundation
import Vapor

final class UserAddressController {
    func getAddress(_ request: Request) throws -> Future<AddressResponse> {
        return try request.content.decode(AddressRequest.self).flatMap { info in
            UserToken.query(on: request).filter(\UserToken.accessToken, .equal, info.accessToken).first().flatMap { result in
                guard let resultToken = result else {
                    throw Abort(.badRequest, reason: "Nonauthorized session")
                }
                let expire = resultToken.expiresAt;
                let now = Int(Date().timeIntervalSince1970)
                if expire < now {
                    throw Abort(.badRequest, reason: "User Access-Token out of date")
                }
                
                return UserAddress.query(on: request).filter(\UserAddress.userID, .equal, resultToken.userID).first().map { address in
                    guard let address = address else {
                        throw Abort(.badRequest, reason: "No user found")
                    }
                    return AddressResponse(country: address.country, city: address.city, line1: address.line1, line2: address.line2, house: address.house, apartment: address.apartment)
                }
            }
        }
    }
    
    func updateAddress(_ request: Request) throws -> Future<AddressResponse> {
        return try request.content.decode(UpdateAddressRequest.self).flatMap { info in
            UserToken.query(on: request).filter(\UserToken.accessToken, .equal, info.accessToken).first().flatMap { result in
                guard let resultToken = result else {
                    throw Abort(.badRequest, reason: "Nonauthorized session")
                }
                let expire = resultToken.expiresAt;
                let now = Int(Date().timeIntervalSince1970)
                if expire < now {
                    throw Abort(.badRequest, reason: "User Access-Token out of date")
                }
                
                return UserAddress.query(on: request).filter(\UserAddress.userID, .equal, resultToken.userID).first().flatMap { address in
                    guard let address = address else {
                        throw Abort(.badRequest, reason: "No user found")
                    }
                    address.country = info.country
                    address.city = info.city
                    address.line1 = info.line1
                    address.line2 = info.line2
                    address.house = info.house
                    address.apartment = info.apartment
                    
                    return address.update(on: request).map { updated in
                        return AddressResponse(country: updated.country, city: updated.city, line1: updated.line1, line2: updated.line2, house: updated.house, apartment: updated.apartment)
                    }
                }
            }
        }
    }
}
