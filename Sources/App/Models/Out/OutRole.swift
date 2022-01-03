//
//  File.swift
//  
//
//  Created by laijihua on 2022/1/3.
//

import Foundation


struct OutRole: Out {
    let id: UUID?
    let name: String
    
    init(from: Role) {
        id = from.id
        name = from.name
    }
}
