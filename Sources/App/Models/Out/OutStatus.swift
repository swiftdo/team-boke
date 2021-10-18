//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Foundation

protocol OutCodeMsg {
    var code: Int { get }
    var message: String { get }
}

struct OutStatus: Out, OutCodeMsg {
    var code: Int
    var message: String

    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

extension OutStatus {
    static var ok = OutStatus(code: 0, message: "请求成功")
    static var userExist = OutStatus(code: 20, message: "用户已经存在")
    static var userNotExist = OutStatus(code: 21, message: "用户不存在")
    static var passwordError = OutStatus(code: 22, message: "密码错误")
    static var emailNotExist = OutStatus(code: 23, message: "邮箱不存在")
    static var accessTokenNotExist = OutStatus(code: 24, message: "access_token不存在")
    static var refreshTokenNotExist = OutStatus(code: 25, message: "refresh_token不存在")
    static var invalidEmailOrPassword = OutStatus(code: 26, message: "邮箱或密码错误")
    static var subjectExist = OutStatus(code: 27, message: "subject已经存在")
    static var subjectNotExist = OutStatus(code: 28, message: "subject不存在")
    static var missParameters = OutStatus(code: 29, message: "参数不完整")
    static var tagNotExist = OutStatus(code: 30, message: "tag不存在")
    static var topicNotExist = OutStatus(code: 31, message: "topic不存在")
    static var catalogNotExist = OutStatus(code: 32, message: "catalog不存在")
    static var bookletNotExist = OutStatus(code: 33, message: "booklet不存在")
    static var emailTokenNotExist = OutStatus(code: 34, message: "emailtoken 不存在")
    static var emailTokenFail = OutStatus(code: 35, message: "emailtoken 已失效")
    static var userAuthNotExist = OutStatus(code: 36, message: "userAuth 不存在")
    static var roleNotExist = OutStatus(code: 37, message: "role 不存在")
    static var permissionNotExist = OutStatus(code: 38, message: "permission 不存在")
    static var permissionInsufficient = OutStatus(code: 39, message: "您没有访问权限")
}
