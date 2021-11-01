//
//  File.swift
//  
//
//  Created by laijihua on 2021/11/1.
//

import Vapor

struct InRegister: In {
    var name: String
    var email: String
    var password: String
}

extension InRegister: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}




