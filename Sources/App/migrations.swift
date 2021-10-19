//
//  File.swift
//  
//
//  Created by mac on 2021/10/19.
//

import Vapor

func migrations(_ app: Application) throws {
    
    app.migrations.add(CreateRole())
    app.migrations.add(CreatePermission())
    
    app.migrations.add(CreateUser())
    app.migrations.add(CreateUserAuth())
    app.migrations.add(CreateRefreshToken())
    app.migrations.add(CreateAccessToken())
    app.migrations.add(CreateRolePermission())
    
    app.migrations.add(RolePermissionSeed())
}
