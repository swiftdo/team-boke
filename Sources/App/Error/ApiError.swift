//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//
import Vapor

struct ApiError {
    var content: OutStatus

    init(code: OutStatus) {
        self.content = code
    }
}

extension ApiError: AbortError {
    
    var status: HTTPResponseStatus { .ok }

    var reason: String {
        return self.content.message
    }
}
