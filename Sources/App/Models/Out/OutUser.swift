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
    let role: OutRole?

    init(id: UUID? = nil, name: String, email: String, avatar: String?, createdAt: Date?, role: OutRole? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
        self.createdAt = createdAt
        self.role = role
    }

    init(from user: User, role: Role? = nil) {
        let tmpRole = user.role ?? role
        var opt: OutRole?
        if let tmp = tmpRole {
            opt = OutRole(from: tmp)
        }
        
        self.init(id: user.id, name: user.name, email: user.email, avatar: user.avatar, createdAt: user.createdAt, role: opt)
    }
    
    
}
