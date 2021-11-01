//
//  File.swift
//  
//
//  Created by laijihua on 2021/11/1.
//

import Crypto
import Foundation

extension SHA256Digest: NamespaceWrappable {}
extension TypeWrapperProtocol where WrappedType == SHA256Digest {
    var base64: String {
        Data(warppedValue).base64EncodedString()
    }
    var base64URLEncoded: String {
        Data(warppedValue).ob.base64URLEncodedString()
    }
}

extension SHA256: NamespaceWrappable {}
extension TypeWrapperProtocol where WrappedType == SHA256 {
    /// Returns hex-encoded string
    static func hash(_ string: String) -> String {
        hash(data: string.data(using: .utf8)!)
    }

    /// Returns a hex encoded string
    static func hash<D>(data: D) -> String where D : DataProtocol {
        SHA256.hash(data: data).hex
    }
}


extension Data: NamespaceWrappable {}
extension TypeWrapperProtocol where WrappedType == Data {
    public func base64URLEncodedString(options: Data.Base64EncodingOptions = []) -> String {
        return self.warppedValue
            .base64EncodedString(options: options)
            .ob
            .base64URLEscaped()
    }
}


extension String: NamespaceWrappable {}
extension TypeWrapperProtocol where WrappedType == String {
    public func base64URLEscaped() -> String {
        return self.warppedValue
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }

    public func base64URLUnescaped() -> String {
        let replaced = self.warppedValue
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        /// https://stackoverflow.com/questions/43499651/decode-base64url-to-base64-swift
        let padding = replaced.count % 4
        if padding > 0 {
            return replaced + String(repeating: "=", count: 4 - padding)
        } else {
            return replaced
        }
    }
}

