//
//  File.swift
//
//
//  Created by laijihua on 2021/10/18.
//

import Fluent
import Foundation

struct RolePermissionSeed: AsyncMigration {
    func prepare(on database: Database) async throws {
        let allPers: [Seed.Permission] = Seed.Permission.allCases
        let allRols: [Seed.Role] = Seed.Role.allCases

        try await allPers.compactMap { per in
            Permission(name: per.string)
        }.create(on: database)

        for erole in allRols {
            let role = Role(name: erole.string)
            try await role.create(on: database)

            for eper in erole.permissions {
                let rolePers = try await Permission
                    .query(on: database)
                    .filter(\.$name == eper.string)
                    .all()

                for rolePer in rolePers {
                    try await rolePer.$roles.attach(role, on: database)
                }
            }
        }
    }

    func revert(on database: Database) async throws {
        try await Role.query(on: database).delete()
        try await Permission.query(on: database).delete()
    }
}
