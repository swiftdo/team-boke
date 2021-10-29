//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Fluent

struct CreateAccessToken: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema(AccessToken.schema)
            .id()
            .field(AccessToken.FieldKeys.userId, .uuid, .references(User.schema, .id))
            .field(AccessToken.FieldKeys.token, .string, .required)
            .field(AccessToken.FieldKeys.expiresAt, .datetime, .required)
            .unique(on: AccessToken.FieldKeys.userId)
            .unique(on: AccessToken.FieldKeys.token)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(AccessToken.schema).delete()
    }
}
