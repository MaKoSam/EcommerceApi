//
//  AuthController.swift
//  App
//
//  Created by Sam Mazniker on 23/04/2020.
//

import Foundation
import Vapor
import Crypto

final class AuthController {
    
    func register(_ request: Request) throws -> Future<AuthResponse> {
        return try request.content.decode(RegisterUserRequest.self).flatMap { user in
            
            if user.password.count < 6 {
                throw Abort(.badRequest, reason: "Password bad format")
            }
            
            let passwordHash = try BCrypt.hash(user.password)
            let newUser = Users.init(username: user.username, email: user.email, passwordHash: passwordHash)
            
            return newUser.save(on: request).flatMap { createdUser in
                let accessToken = try UserToken.create(userID: createdUser.requireID())
                return accessToken.save(on: request).flatMap { resultToken in
                    
                    let userInfo = try UserInfo.create(for: createdUser.requireID(), email: createdUser.email)
                    return userInfo.save(on: request).flatMap { saved in
                        
                        let userAddress = try UserAddress.create(for: createdUser.requireID())
                        return userAddress.save(on: request).map { address in
                            
                            return AuthResponse(accessToken: resultToken.accessToken, refreshToken: resultToken.refreshToken)
                        }
                    }
                }
            }
        }
    }
    
    func signin(_ request: Request) throws -> Future<AuthResponse>{
        return try request.content.decode(AuthRequest.self).flatMap { auth in
            Users.query(on: request).filter(\Users.username, .equal, auth.username).first().flatMap { result in
                guard let result = result,
                    let userID = result.id else {
                    throw Abort(.badRequest, reason: "User doesn't exist or password is wrong")
                }
                
                guard try BCrypt.verify(auth.password, created: result.passwordHash) else {
                    throw Abort(.badRequest, reason: "User doesn't exist or password is wrong")
                }
                
                return UserToken.query(on: request).filter(\UserToken.userID, .equal, userID).first().map { userToken in
                    guard let token = userToken?.accessToken,
                        let expires = userToken?.expiresAt,
                        let refreshToken = userToken?.refreshToken else {
                            throw Abort(.badRequest, reason: "User doesn't exist or password is wrong")
                    }
                    
                    return AuthResponse(accessToken: token, refreshToken: refreshToken, expires: expires)
                }
                
            }
            
        }
    }
    /*
    func restorePassword(_ request: Request) -> Future<HTTPResponse>{
        
    }
    
    func refreshToken(_ request: Request) -> Future<HTTPResponse>{
        
    }
    */
    
}
