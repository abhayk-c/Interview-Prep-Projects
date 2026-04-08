//
//  KeyValueStoreActor.swift
//  SwiftConcurrency
//
//  Created by Abhay Curam on 11/14/25.
//

import Foundation

/**
 * Because these methods are part of a protocol interface async is needed.
 * Otherwise if these functions were directly added on the Actor async would not
 * be needed and essentially be implied. Its because protocol's are meant to be used
 * by Actors and non-Actors so the async must be explicit in the function signature.
 */
public protocol KeyValueStoreActorInterface {
    func setValueForKey(_ key: String, _ value: Data) async throws(Error) -> KeyValueWriteResult
    func removeValueForKey(_ key: String) async throws(Error) -> KeyValueWriteResult
    func getValueForKey(_ key: String) async throws(Error) -> KeyValueReadResult
}

public actor KeyValueStoreActor: KeyValueStoreActorInterface {
    
    private let storageLocation: KeyValueStorageLocation
    
    public init(_ storageLocation: KeyValueStorageLocation) {
        self.storageLocation = storageLocation
    }
    
    public func setValueForKey(_ key: String, _ value: Data) throws(any Error) -> KeyValueWriteResult {
        print("Calling setValueForKey for key: \(key)")
        let keyFilePath = getFilePathStringForKey(key)
        let createDirError = createStorageDirectoryIfNeeded()
        if let unwrappedCreateDirError = createDirError {
            throw unwrappedCreateDirError
        }
        if FileManager.default.fileExists(atPath: keyFilePath) {
            do {
                try FileManager.default.removeItem(atPath: keyFilePath)
            } catch let error as NSError {
                throw error
            }
        }
        let writeFileResult = FileManager.default.createFile(atPath: keyFilePath, contents: value)
        if writeFileResult {
            return KeyValueWriteResult(didSucceed: true, key: key)
        } else {
            let error = NSError(domain: "Failed to write file at: \(keyFilePath)", code: 0, userInfo: nil)
            throw error
        }
    }
    
    public func removeValueForKey(_ key: String) throws(any Error) -> KeyValueWriteResult {
        print("Calling removeValueForKey for key: \(key)")
        let keyFilePath = getFilePathStringForKey(key)
        if FileManager.default.fileExists(atPath: keyFilePath) {
            do {
                try FileManager.default.removeItem(atPath: keyFilePath)
            } catch let error as NSError {
                throw error
            }
            return KeyValueWriteResult(didSucceed: true, key: key)
        }
        return KeyValueWriteResult(didSucceed: true, key: key)
    }
    
    public func getValueForKey(_ key: String) throws(any Error) -> KeyValueReadResult {
        print("Calling getValueForKey for key: \(key)")
        let keyFilePath = getFilePathStringForKey(key)
        if FileManager.default.fileExists(atPath: keyFilePath) {
            let value = FileManager.default.contents(atPath: keyFilePath)
            let result = KeyValueReadResult(data: value, key: key)
            return result
        } else {
            let result = KeyValueReadResult(data: nil, key: key)
            return result
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
