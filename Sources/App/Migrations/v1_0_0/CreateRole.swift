//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Fluent

struct CreateRole: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Role.schema)
            .id()
            .field(Role.FieldKeys.name, .string, .required)
            .unique(on: Role.FieldKeys.name)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Role.schema).delete()
    }
}
