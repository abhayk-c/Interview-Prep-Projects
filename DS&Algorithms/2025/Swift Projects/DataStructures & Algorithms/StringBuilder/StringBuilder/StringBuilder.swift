//
//  StringBuilder.swift
//  StringBuilder
//
//  Created by Abhay Curam on 5/21/25.
//

import Foundation

final public class CharacterBuffer
{
    var buffer: [Character]
    init(_ data: [Character]) {
        buffer = data
    }
}

private protocol StringBuilder
{
    init(_ string: String)
    mutating func append(character: Character)
    mutating func append(string: String)
}

/*
 * A Java like StringBuilder object implemented as a COW (copy on write)
 * Value Type. This is really nothing but a barebones NSMutableString that just makes
 * performance of concatenated static strings better. Internally we are using Swift
 * value types and arrays only for storage.
 *
 * I implemented this data structure to learn about COW types and implement my own.
 * The internals of the class such as Storage and CharacterBuffer would normally be kept
 * private but I exposed them to test and verify the Copy on Write semantic worked correctly.
 */
public struct SwiftStringBuilder : StringBuilder
{
    public var storage: CharacterBuffer
    
    public init() {
        storage = CharacterBuffer([])
    }
    
    public init(_ string: String) {
        storage = CharacterBuffer(Array(string))
    }
    
    public mutating func append(character: Character) {
        if !isKnownUniquelyReferenced(&storage) {
            storage = CharacterBuffer(storage.buffer)
        }
        storage.buffer.append(character)
    }
    
    public mutating func append(string: String) {
        if !isKnownUniquelyReferenced(&storage) {
            storage = CharacterBuffer(storage.buffer)
        }
        storage.buffer.append(contentsOf: string)
    }
    
    public func toString() -> String {
        return String(storage.buffer)
    }
}

/*
 * This is the same as above, a StringBuilder object that implements a COW semantic.
 * The difference is the storage is using a Objc Reference object directly instead of
 * a value type boxed in a reference. The COW behavior and ref counting works exactly the same.
 * This was for learning purposes.
 */
public struct ObjcStringBuilder : StringBuilder
{
    public var storage: NSMutableString
    
    public init() {
        storage = NSMutableString()
    }
    
    public init(_ string: String) {
        storage = NSMutableString(string: string)
    }
    
    public mutating func append(character: Character) {
        if !isKnownUniquelyReferenced(&storage) {
            storage = NSMutableString(string: storage as String)
        }
        storage.append(String(character))
    }
    
    public mutating func append(string: String) {
        if !isKnownUniquelyReferenced(&storage) {
            storage = NSMutableString(string: storage as String)
        }
        storage.append(string)
    }
    
    public func toString() -> String {
        return storage as String
    }
    
}

