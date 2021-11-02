//
//  File.swift
//  
//
//  Created by mac on 2021/10/18.
//

import Vapor
import Fluent

/// 用户认证状态
final class UserAuth: Model {
    static let schema = "user_auths"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: FieldKeys.userId)
    var user: User

    @Enum(key: FieldKeys.authType)
    var authType: AuthType
    
    
    @Field(key: FieldKeys.identifier)
    var identifier: String // 标志 (手机号，邮箱，用户名或第三方应用的唯一标识)
    
    @Field(key: FieldKeys.credential)
    var credential: String // 密码凭证(站内的保存密码， 站外的不保存或保存 token)
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?

    init() { }

    init(id: UUID? = nil, userId: UUID, authType: AuthType = .email, identifier: String, credential: String) {
        self.id = id
        self.$user.id = userId
        self.authType = authType
        self.identifier = identifier
        self.credential = credential
    }
}

extension UserAuth {
    struct FieldKeys {
        static var userId: FieldKey { "user_id" }
        static var authType: FieldKey { "auth_type" }
        static var identifier: FieldKey { "identifier" }
        static var credential: FieldKey { "credential" }
        static var createdAt: FieldKey { "created_at" }
        static var updatedAt: FieldKey { "updated_at" }
    }
}

extension UserAuth {
    enum AuthType: String, Codable {
        static let schema = "AUTHTYPE"
        case email, wxapp
    }
}


extension UserAuth: ModelAuthenticatable {
    static let usernameKey = \UserAuth.$identifier
    static let passwordHashKey = \UserAuth.$credential

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.credential)
    }
}

extension UserAuth: SessionAuthenticatable {
    typealias SessionID = String
    var sessionID: SessionID {
        self.identifier
    }
}

struct UserSessionAuthenticator: AsyncSessionAuthenticator {
    typealias User = UserAuth
    
    func authenticate(sessionID: String, for request: Request) async throws {
        let userAuth = try await UserAuth.query(on: request.db).filter(\.$identifier == sessionID).first()
        
        if let ua = userAuth {
            let user = try await ua.$user.get(on: request.db)
            request.auth.login(user)
        }
    }
}


