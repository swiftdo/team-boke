//
//  File.swift
//  
//
//  Created by laijihua on 2021/11/1.
//

import Foundation

struct OutToken: Out {
    let accessToken: AccessToken.Token
    let expiresAt: TimeInterval
    let refreshToken: RefreshToken.Token

    init(accessToken: AccessToken, refreshToken: RefreshToken) {
        self.accessToken = accessToken.token
        self.expiresAt = accessToken.expiresAt.timeIntervalSince1970
        self.refreshToken = refreshToken.token
    }
}
