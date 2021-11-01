//
//  File.swift
//  
//
//  Created by laijihua on 2021/11/1.
//

import Vapor

struct InLogin: In {
    let email: String
    let password: String
}

extension InLogin: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}
