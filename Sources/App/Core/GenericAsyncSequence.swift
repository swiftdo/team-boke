//
//  File.swift
//  
//
//  Created by laijihua on 2021/10/31.
//

import Foundation
import CryptoKit

struct GenericAsyncSequence<Element>: AsyncSequence {
    
    typealias AysncInterator = GenericAsyncIterator<Element>
    
    private let elements: [Element]
    
    struct GenericAsyncIterator<Element>: AsyncIteratorProtocol {
        
        private var elements: [Element]
        
        init(_ elements: [Element]) {
            self.elements = elements
        }
        
        mutating func next() async throws -> Element? {
            if !self.elements.isEmpty {
                return self.elements.removeFirst()
            }
            else {
                return nil
            }
        }
    }
    
    init(_ elements: [Element]) {
        self.elements = elements
    }
    
    func makeAsyncIterator() -> AysncInterator {
        GenericAsyncIterator(self.elements)
    }
}

extension Array {
    func asyncCompactMap<ElementOfResult>(
            _ transform: @escaping (Element) async throws -> ElementOfResult?)
            async rethrows -> AsyncThrowingCompactMapSequence<GenericAsyncSequence<Element>, ElementOfResult>
        {
            GenericAsyncSequence(self).compactMap(transform)
        }
}
