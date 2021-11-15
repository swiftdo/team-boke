//
//  File.swift
//  
//
//  Created by laijihua on 2021/11/1.
//

import Foundation

struct OutUser: Out {
    let id: UUID?
    let name: String
    let email: String
    let avatar: String?
    let createdAt: Date?

    init(id: UUID? = nil, name: String, email: String, avatar: String?, createdAt: Date?) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
        self.createdAt = createdAt
    }

    init(from user: User) {
        self.init(id: user.id, name: user.name, email: user.email, avatar: user.avatar, createdAt: user.createdAt)
    }
}
