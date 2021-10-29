//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Fluent

struct CreateRole: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema(Role.schema)
            .id()
            .field(Role.FieldKeys.name, .string, .required)
            .unique(on: Role.FieldKeys.name)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(Role.schema).delete()
    }
    
}
