//
//  File.swift
//  
//
//  Created by mac on 2021/10/18.
//

import Vapor
import Fluent

/// 用户表，存放用户信息
final class User: Model {
    // 表名
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: FieldKeys.name)
    var name: String
    
    @Field(key: FieldKeys.email)
    var email: String
    
    @Field(key: FieldKeys.isEmailVerified)
    var isEmailVerified: Bool // 邮箱状态
    
    @Field(key: FieldKeys.avatar)
    var avatar: String?

    @Field(key: FieldKeys.lastSignAt)
    var lastSignAt: Date? // 最近一次登录时间



    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    @Children(for: \.$user)
    var userAuths: [UserAuth] // 1对多
    
    @OptionalParent(key: FieldKeys.roleId)
    var role: Role?


    init() { }

    init(id: UUID? = nil, name: String, email: String, isEmailVerified: Bool = false, avatar: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.isEmailVerified = isEmailVerified
        self.avatar = avatar
    }
}

extension User {
    struct FieldKeys {
        static var name: FieldKey { "name" }
        static var email: FieldKey {"email" }
        static var isEmailVerified: FieldKey { "is_email_verified" }
        static var avatar: FieldKey { "avatar" }
        static var createdAt: FieldKey { "created_at" }
        static var updatedAt: FieldKey { "updated_at" }
        static var roleId: FieldKey { "role_id" }
        static var lastSignAt: FieldKey { "last_sign_at" }
        static var blocked: FieldKey { "blocked" }
        static var bannedToPost: FieldKey { "banned_to_post" }
        static var gender: FieldKey {"gender"}
        static var brief: FieldKey {"brief"}
        static var source: FieldKey { "source"}
        static var postCount: FieldKey {"post_count"}
        
    }
}

extension User: Authenticatable {}

extension User: ModelSessionAuthenticatable {}
