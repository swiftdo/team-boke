//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/18.
//

import Vapor

func services(_ app: Application) throws {
    app.randomGenerators.use(.random)
}
