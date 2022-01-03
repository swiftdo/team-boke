//
//  File.swift
//  
//
//  Created by laijihua on 2022/1/3.
//

import Foundation

class InEditUser : In {
    let id: String // 毕传用户id
    let name: String?
    let email: String?
    let roleId: String? // role id
}

extension InEditUser: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("id", as: String.self, is: .nil)
    }
}

