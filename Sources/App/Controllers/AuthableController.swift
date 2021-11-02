//
//  File.swift
//  
//
//  Created by laijihua on 2021/11/2.
//

import Vapor
import Fluent

protocol AuthableController: RouteCollection {
    func getUserAuth(email: String, req: Request) async throws -> UserAuth?
    func removeAllTokensFor(userId: UUID, req: Request) async throws
    func createTokenFor(userId: UUID, req: Request) async throws -> OutToken
}

extension AuthableController {
    func getUserAuth(email: String, req: Request) async throws -> UserAuth? {
        return try await UserAuth.query(on: req.db)
            .filter(\.$authType == .email)
            .filter(\.$identifier == email)
            .first()
    }
    
    func removeAllTokensFor(userId: UUID, req: Request) async throws {
        try await AccessToken
            .query(on: req.db)
            .filter(\.$user.$id == userId)
            .delete()
        
        try await RefreshToken
            .query(on: req.db)
            .filter(\.$user.$id == userId)
            .delete()
    }
    
    func createTokenFor(userId: UUID, req: Request) async throws -> OutToken{
        let token = SHA256.ob.hash(req.random.generate(bits: 256))
        let at = AccessToken(userId: userId, token: token)
        try await at.create(on: req.db)
        
        let ref = SHA256.ob.hash(req.random.generate(bits: 256))
        let rt = RefreshToken(userId: userId, token: ref)
        try await rt.create(on: req.db)
        
        return OutToken(accessToken: at, refreshToken: rt)
    }
}
