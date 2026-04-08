//
//  KeyValueStore.swift
//  MobileDomainProblems
//
//  Created by Abhay Curam on 11/4/25.
//

import Foundation

public protocol KeyValueStoreInterface {
    func setValueForKey(_ key: String, _ value: Data, _ completion: @escaping ((Bool, Error?) -> Void))
    func removeValueForKey(_ key: String, _ completion: @escaping ((Bool, Error?) -> Void))
    func getValueForKey(_ key: String, _ completion: @escaping ((Data?, Error?) -> Void))
}

public struct KeyValueStorageLocation {
    public let storageDirectoryURL: URL
    public let storageDirectoryPathString: String
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
                               _ completion: @escaping ((Bool, (any Error)?) -> Void)) {
        serialBackgroundQueue.async { [weak self] in
            if let strongSelf = self {
                let keyFilePath = strongSelf.getFilePathStringForKey(key)
                let createDirError = strongSelf.createStorageDirectoryIfNeeded()
                if createDirError != nil { completion(false, createDirError) }
                if FileManager.default.fileExists(atPath: keyFilePath) {
                    do {
                        try FileManager.default.removeItem(atPath: keyFilePath)
                    } catch let error as NSError {
                        completion(false, error)
                    }
                }
                let writeFileResult = FileManager.default.createFile(atPath: keyFilePath, contents: value)
                completion(writeFileResult, nil) //would be cleaner to throw a local error here.
            }
        }
    }
    
    public func removeValueForKey(_ key: String,
                                  _ completion: @escaping ((Bool, (any Error)?) -> Void)) {
        serialBackgroundQueue.async { [weak self] in
            if let strongSelf = self {
                let keyFilePath = strongSelf.getFilePathStringForKey(key)
                if FileManager.default.fileExists(atPath: keyFilePath) {
                    do {
                        try FileManager.default.removeItem(atPath: keyFilePath)
                    } catch let error as NSError {
                        completion(false, error)
                    }
                }
                completion(true, nil) //again local error if file does not exist could be cleaner.
            }
        }
    }
    
    public func getValueForKey(_ key: String,
                               _ completion: @escaping ((Data?, (any Error)?) -> Void)) {
        serialBackgroundQueue.async { [weak self] in
            if let strongSelf = self {
                let keyFilePath = strongSelf.getFilePathStringForKey(key)
                if FileManager.default.fileExists(atPath: keyFilePath) {
                    let value = FileManager.default.contents(atPath: keyFilePath)
                    completion(value, nil)
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
        return storageLocation.storageDirectoryURL.appending(path: key).absoluteString
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

