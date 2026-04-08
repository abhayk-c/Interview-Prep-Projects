//
//  KeyValueStore.swift
//  SwiftConcurrency
//
//  Created by Abhay Curam on 11/14/25.
//

import Foundation

public protocol KeyValueStoreInterface {
    func setValueForKey(_ key: String, _ value: Data, _ completion: @escaping ((KeyValueWriteResult, Error?) -> Void))
    func removeValueForKey(_ key: String, _ completion: @escaping ((KeyValueWriteResult, Error?) -> Void))
    func getValueForKey(_ key: String, _ completion: @escaping ((KeyValueReadResult, Error?) -> Void))
}

/**
 * Lightweight test cases and some local error propagation would
 * close the loop here if you have some time. But roughly the right approach.
 */
public class KeyValueStore: KeyValueStoreInterface {
    
    public let storageLocation: KeyValueStorageLocation
    public let serialBackgroundQueue: DispatchQueue
    
    public init(_ storageLocation: KeyValueStorageLocation) {
        self.storageLocation = storageLocation
        self.serialBackgroundQueue = DispatchQueue(label: "keyvaluestore.background.serial")
    }
    
    public func setValueForKey(_ key: String,
                               _ value: Data,
                               _ completion: @escaping ((KeyValueWriteResult, (any Error)?) -> Void)) {
        serialBackgroundQueue.async { [weak self] in
            if let strongSelf = self {
                let keyFilePath = strongSelf.getFilePathStringForKey(key)
                let createDirError = strongSelf.createStorageDirectoryIfNeeded()
                if createDirError != nil {
                    completion(KeyValueWriteResult(didSucceed: false, key: key), createDirError)
                }
                if FileManager.default.fileExists(atPath: keyFilePath) {
                    do {
                        try FileManager.default.removeItem(atPath: keyFilePath)
                    } catch let error as NSError {
                        completion(KeyValueWriteResult(didSucceed: false, key: key), error)
                    }
                }
                let writeFileResult = FileManager.default.createFile(atPath: keyFilePath, contents: value)
                if writeFileResult {
                    let result = KeyValueWriteResult(didSucceed: true, key: key)
                    completion(result, nil)
                } else {
                    let error = NSError(domain: "Failed to write file at: \(keyFilePath)", code: 0, userInfo: nil)
                    let result = KeyValueWriteResult(didSucceed: false, key: key)
                    completion(result, error)
                }
            }
        }
    }
    
    public func removeValueForKey(_ key: String,
                                  _ completion: @escaping ((KeyValueWriteResult, (any Error)?) -> Void)) {
        serialBackgroundQueue.async { [weak self] in
            if let strongSelf = self {
                let keyFilePath = strongSelf.getFilePathStringForKey(key)
                if FileManager.default.fileExists(atPath: keyFilePath) {
                    do {
                        try FileManager.default.removeItem(atPath: keyFilePath)
                    } catch let error as NSError {
                        let result = KeyValueWriteResult(didSucceed: false, key: key)
                        completion(result, error)
                    }
                    let result = KeyValueWriteResult(didSucceed: true, key: key)
                    completion(result, nil)
                }
                
            }
        }
    }
    
    public func getValueForKey(_ key: String,
                               _ completion: @escaping ((KeyValueReadResult, (any Error)?) -> Void)) {
        serialBackgroundQueue.async { [weak self] in
            if let strongSelf = self {
                let keyFilePath = strongSelf.getFilePathStringForKey(key)
                if FileManager.default.fileExists(atPath: keyFilePath) {
                    let value = FileManager.default.contents(atPath: keyFilePath)
                    let result = KeyValueReadResult(data: value, key: key)
                    completion(result, nil)
                } else {
                    let result = KeyValueReadResult(data: nil, key: key)
                    completion(result, nil)
                }
            }
        }
    }
    
    private func getFilePathURLForKey(_ key: String) -> URL
    {
        return storageLocation.storageDirectoryURL.appending(path: key)
    }
    
    private func getFilePathStringForKey(_ key: String) -> String
    {
        return storageLocation.storageDirectoryURL.appending(path: key).path
    }
    
    private func createStorageDirectoryIfNeeded() -> Error?
    {
        if !FileManager.default.fileExists(atPath: storageLocation.storageDirectoryPathString) {
            do {
                try FileManager.default.createDirectory(atPath: storageLocation.storageDirectoryPathString, withIntermediateDirectories: false)
            } catch let error as NSError {
                return error
            }
        }
        return nil
    }
    
}

