//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Fluent

struct CreatePermission: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Permission.schema)
            .id()
            .field(Permission.FieldKeys.name, .string, .required)
            .unique(on: Permission.FieldKeys.name)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Permission.schema).delete()
    }
}
