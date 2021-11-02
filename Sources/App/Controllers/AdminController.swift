//
//  File.swift
//  
//
//  Created by laijihua on 2021/11/2.
//

import Fluent
import Vapor
import Foundation

struct AdminController: AuthableController {
    func boot(routes: RoutesBuilder) throws {
        routes.group("admin") { admin in
            admin.post("register", use: register)
            admin.post("login", use: login)
        }
    }
}

extension AdminController {
    private func login(_ req: Request) async throws -> View{
        try InLogin.validate(content: req)
        let inLogin = try req.content.decode(InLogin.self)
        
        let ua = try await getUserAuth(email: inLogin.email, req: req)
        
        guard let userAuth = ua else {
            return try await req.view.render("/auth/login", LoginContext(error: "该邮箱未注册"))
        }
        
        // 判断密码是否正确
        let isAuth = try await req
            .password
            .async
            .verify(inLogin.password,created: userAuth.credential)
        
        guard isAuth else {
            return try await req.view.render("/auth/login", LoginContext(error: "邮箱或者密码不正确"))
        }
        
        let user = try await userAuth.$user.get(on: req.db)
        
        req.auth.login(user)
        
        let userId = try user.requireID()
        
        // 先将旧的token都进行移除
        try await removeAllTokensFor(userId: userId, req: req)
        
        let token = try await createTokenFor(userId: userId, req: req)
        
        return try await req.view.render("/auth/login")
    }
    
    private func register(_ req: Request) async throws -> View{
        
        try InRegister.validate(content: req)
        let inRegister = try req.content.decode(InRegister.self)
        let userAuth = try await getUserAuth(email: inRegister.email, req: req)

        guard userAuth == nil else {
            return try await req.view.render("/auth/register", LoginContext(error: "该邮箱已注册"))
        }

        let user = User(name: inRegister.name, email: inRegister.email)

        var roleType = Seed.Role.user

        if user.email == req.myConfig.adminEmail {
            roleType = Seed.Role.administrator
        }

        let role: Role = try await Role
            .query(on: req.db)
            .filter(\.$name == roleType.string)
            .first()!

        user.$role.id = role.id
        
        try await user.create(on: req.db)

        // 保存的应该不是密码
        let pwd = try await req.password.async.hash(inRegister.password)
        
        let ua = try UserAuth(userId: user.requireID(),
                              authType: .email,
                              identifier: inRegister.email,
                              credential: pwd)
        
        try await ua.create(on: req.db)
        return try await req.view.render("/admin/dashboard")
    }
    
}
