//
//  KeyValueResult.swift
//  SwiftConcurrency
//
//  Created by Abhay Curam on 11/14/25.
//

import Foundation

public struct KeyValueWriteResult {
    let didSucceed: Bool
    let key: String
    public init(didSucceed: Bool, key: String) {
        self.didSucceed = didSucceed
        self.key = key
    }
}
public struct KeyValueReadResult {
    let data: Data?
    let key: String
    public init(data: Data?, key: String) {
        self.data = data
        self.key = key
    }
}
