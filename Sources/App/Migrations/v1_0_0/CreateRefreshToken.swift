//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Fluent

struct CreateRefreshToken: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(RefreshToken.schema)
            .id()
            .field(RefreshToken.FieldKeys.userId, .uuid, .references(User.schema, .id))
            .field(RefreshToken.FieldKeys.token, .string, .required)
            .field(RefreshToken.FieldKeys.expiresAt, .datetime, .required)
            .unique(on:RefreshToken.FieldKeys.userId)
            .unique(on:RefreshToken.FieldKeys.token)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(RefreshToken.schema).delete()
    }


}
