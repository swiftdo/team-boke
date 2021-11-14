//
//  File.swift
//  
//
//  Created by laijihua on 2021/11/14.
//

import Foundation
import Fluent

protocol AdminContext: Encodable {
    var user: OutUser { get }
    var path: String { get }
}

struct AdminPageContext: AdminContext {
    let user: OutUser
    let path: String // 当前的路由
    
    // 分页
    let page: Int
    let per: Int
    let result: Page<OutUser>
}
