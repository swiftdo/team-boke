//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//


import Fluent

struct CreateRolePermission: AsyncMigration {
    
    func prepare(on database: Database) async throws {
       try await database.schema(RolePermission.schema)
            .id()
            .field(RolePermission.FieldKeys.roleId, .uuid, .required, .references(Role.schema, .id))
            .field(RolePermission.FieldKeys.permissionId, .uuid, .required, .references(Permission.schema, .id))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(RolePermission.schema).delete()
    }
    
}
