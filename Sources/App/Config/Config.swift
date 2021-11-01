//
//  File.swift
//  
//
//  Created by laijihua on 2021/11/1.
//

import Vapor

// services

struct MyConfig {
    let adminEmail = "1164258202@qq.com"
}

struct MyConfigKey: StorageKey {
    typealias Value = MyConfig
}

extension Application {
    var myConfig: MyConfig? {
        get {
            self.storage[MyConfigKey.self]
        }
        set {
            self.storage[MyConfigKey.self] = newValue
        }
    }
}

extension Request {
    var myConfig: MyConfig {
        return application.myConfig!
    }
}
