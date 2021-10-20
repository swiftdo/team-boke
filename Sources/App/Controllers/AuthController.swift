//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/20.
//

import Vapor

struct AuthController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.group("auth") { auth in
            
        }
    }
}
