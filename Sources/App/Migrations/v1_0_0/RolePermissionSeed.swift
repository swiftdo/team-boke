//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Fluent

struct RolePermissionSeed: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        let allPers: [Seed.Permission] = Seed.Permission.allCases
        let allRols: [Seed.Role] = Seed.Role.allCases
        
        let createPermissionFuture = allPers
            .compactMap { permission in
                return Permission(name: permission.string).save(on: database)
            }
            .flatten(on: database.eventLoop)
            
        return createPermissionFuture
            .flatMap { _ -> EventLoopFuture<Void> in
             return allRols
                .compactMap { erole in
                    let role = Role(name: erole.string)
                    return role
                        .save(on: database)
                        .flatMap { _ -> EventLoopFuture<Void> in
                            return erole
                                .permissions
                                .compactMap { epermission in
                                return Permission
                                    .query(on: database)
                                    .filter(\.$name == epermission.string)
                                    .first()
                                    .unwrap(or: ApiError(code: .permissionNotExist))
                                    .flatMap { permission in
                                        return permission.$roles.attach(role, on: database)
                                    }
                            }.flatten(on: database.eventLoop)
                        }
                }.flatten(on: database.eventLoop)
            }

    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            Role.query(on: database).delete(),
            Permission.query(on: database).delete(),
        ])
    }
}
