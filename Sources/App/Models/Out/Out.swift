//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Vapor


protocol Out: Content {}


extension String: Out {
    
}

extension Array: Out where Element: Out {

}



