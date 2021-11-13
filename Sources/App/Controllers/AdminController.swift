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
        let authSessionsRoutes = routes.grouped(User.sessionAuthenticator())
        authSessionsRoutes.group("admin") { admin in
            admin.post("register", use: register)
            admin.post("login", use: login)
            
            let authGuard = admin.grouped(User.guardMiddleware())
            authGuard.get("dashboard", use: dashboard)
            authGuard.get("user", use: users)
        }
    }
}

extension AdminController {

    private func users(_ req: Request) async throws -> View {
        // 获取全部用户，以及当前登录的用户信息
        // 然后渲染到用户列表中
        let user = try req.auth.require(User.self)
        req.logger.info("\(user.email)")

        // let users = try await User.query(on: req.db).all()
        // TODO: 
        return try await req.view.render(req.myConfig.routePaths.dashboard, DashboardContext(email: user.email))
    }

    private func dashboard(_ req: Request) async throws -> View {
        let user = try req.auth.require(User.self)
        req.logger.info("\(user.email)")
        return try await req.view.render(req.myConfig.routePaths.dashboard, DashboardContext(email: user.email))
    }
    
    private func login(_ req: Request) async throws -> Response {
        do {
            try InLogin.validate(content: req)
        } catch {
            return try await req
                .view
                .render(req.myConfig.routePaths.login, LoginContext(error: error.localizedDescription))
                .encodeResponse(for: req)
        }
        
        let inLogin = try req.content.decode(InLogin.self)
        let ua = try await getUserAuth(email: inLogin.email, req: req)
        
        guard let userAuth = ua else {
            return try await req
                .view
                .render(req.myConfig.routePaths.login, LoginContext(error: "该邮箱未注册"))
                .encodeResponse(for: req)
        }
        
        // 判断密码是否正确
        let isAuth = try await req
            .password
            .async
            .verify(inLogin.password, created: userAuth.credential)
        
        guard isAuth else {
            return try await req
                .view
                .render(req.myConfig.routePaths.login, LoginContext(error: "邮箱或者密码不正确"))
                .encodeResponse(for: req)
        }
        
        let user = try await userAuth.$user.get(on: req.db)
        req.auth.login(user)
        // TODO: why dashboard not admin/dashboard?, if to "dashboard", to: localhost/admin/dashboard  if "/dashboard", to "localhost/dashboard"
        return req.redirect(to: req.myConfig.routePaths.dashboard, type: .permanent)
    }
    
    private func register(_ req: Request) async throws -> Response {

        do {
            try InRegister.validate(content: req)
        } catch {
            return try await req
                .view
                .render(req.myConfig.routePaths.register, RegisterContext(error: error.localizedDescription))
                .encodeResponse(for: req)
        }
        
        
        let inRegister = try req.content.decode(InRegister.self)
        let userAuth = try await getUserAuth(email: inRegister.email, req: req)

        guard userAuth == nil else {
            return try await req
                .view
                .render(req.myConfig.routePaths.register, RegisterContext(error: "该邮箱已注册"))
                .encodeResponse(for: req)
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

        // 保存的不是pure密码
        let pwd = try await req.password.async.hash(inRegister.password)
        
        let ua = try UserAuth(userId: user.requireID(),
                              authType: .email,
                              identifier: inRegister.email,
                              credential: pwd)
        
        try await ua.create(on: req.db)

        return req.redirect(to: req.myConfig.routePaths.login, type: .permanent)
    }
    
}
