//
//  UserInfo.swift
//  App
//
//  Created by Sam Mazniker on 24/04/2020.
//

import Foundation
import Vapor

final class UserInfoController {
    func getInfo(_ request: Request) throws -> Future<InfoResponse> {
        return try request.content.decode(InfoRequest.self).flatMap { info in
            UserToken.query(on: request).filter(\UserToken.accessToken, .equal, info.accessToken).first().flatMap { result in
                guard let resultToken = result else {
                    throw Abort(.badRequest, reason: "Nonauthorized session")
                }
                let expire = resultToken.expiresAt;
                let now = Int(Date().timeIntervalSince1970)
                if expire < now {
                    throw Abort(.badRequest, reason: "User Access-Token out of date")
                }
                
                return UserInfo.query(on: request).filter(\UserInfo.userID, .equal, resultToken.userID).first().map { info in
                    guard let info = info else {
                        throw Abort(.badRequest, reason: "No user found")
                    }
                    return InfoResponse(name: info.name, email: info.email, phone: info.phone)
                }
            }
        }
    }
    
    func updateInfo(_ request: Request) throws -> Future<InfoResponse> {
        return try request.content.decode(UpdateInfoRequest.self).flatMap { info in
            UserToken.query(on: request).filter(\UserToken.accessToken, .equal, info.accessToken).first().flatMap { result in
                guard let resultToken = result else {
                    throw Abort(.badRequest, reason: "Nonauthorized session")
                }
                let expire = resultToken.expiresAt;
                let now = Int(Date().timeIntervalSince1970)
                if expire < now {
                    throw Abort(.badRequest, reason: "User Access-Token out of date")
                }
                return UserInfo.query(on: request).filter(\UserInfo.userID, .equal, resultToken.userID).first().flatMap { information in
                    guard let information = information else {
                        throw Abort(.badRequest, reason: "No user found")
                    }
                    information.name = info.name
                    information.email = info.email
                    information.phone = info.phone
                    return information.update(on: request).map { updated in
                        return InfoResponse(name: updated.name, email: updated.email, phone: updated.phone)
                    }
                }
            }
        }
    }
}
