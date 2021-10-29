//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Fluent

struct CreateUserAuth: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        
        let authType = try await database.enum(UserAuth.AuthType.schema)
            .case("email")
            .case("wxapp")
            .create()
        
        try await database.schema(UserAuth.schema)
            .id()
            .field(UserAuth.FieldKeys.userId, .uuid, .references(User.schema, .id))
            .field(UserAuth.FieldKeys.authType, authType, .required)
            .field(UserAuth.FieldKeys.identifier, .string, .required)
            .field(UserAuth.FieldKeys.credential, .string, .required)
            .field(UserAuth.FieldKeys.createdAt, .datetime)
            .field(UserAuth.FieldKeys.updatedAt, .datetime)
            .create()
        
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(UserAuth.schema).delete()
        try await database.enum(UserAuth.AuthType.schema).delete()
    }

}
