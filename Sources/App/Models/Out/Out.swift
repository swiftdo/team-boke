//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Vapor
import Fluent

protocol Out: Content {}


extension String: Out {
    
}

extension Array: Out where Element: Out {

}

extension Page: Out where T: Out {}



