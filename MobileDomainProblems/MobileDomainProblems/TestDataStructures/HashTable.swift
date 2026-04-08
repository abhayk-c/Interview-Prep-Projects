//
//  HashTable.swift
//  HashTable
//
//  Created by Abhay Curam on 5/15/25.
//

import Foundation

/**
 * This is thread-safe hashTable implemented leveraging separate chaining.
 * This hashTable is thread-safe. Each bucket contains a dynamic array instead
 * of a linked list. Updated and Inserts are still O(1), but removals become O(N)
 * at each bucket array due to "shifting". In the worst case the insert can be O(N)
 * if the dynamic array at a bucket index must be resized.
 *
 * That being said the avg case runtime for all operations is still O(1)
 * so this implementation is extremely solid. Why? Because the number of elements
 * in each bucket array is usually no greater than 1 or 3, making the remove
 * operation trivial. This also means the array resizing probably never happens
 * in practice. The uniform distribution of the hash function guarantees this.
 * The Leetcode solver said this solution was constant time complexity.
 */
public class HashTable<Key: Hashable, Value: Any>
{
    private struct HashTableNode
    {
        let key: Key
        let value: Value
    }
    
    private let initialCapacity: Int = 16
    private let alpha: Float = 2.0;
    
    /**
     * I thought this was going to be a performance issue because arrays
     * are value types in swift but it's not. It turns out this works similarly to a 2D
     * vector where the outer array just stores pointers/references to the inner arrays
     * where each inner array is separately allocated as its own block on the heap. So its not
     * implemented as one large/flat block.
     *
     * This is because although arrays are value types there storage is actually a
     * reference type that's even managed by ARC. So the actual memory is a pointer to
     * a block on the heap somewhere. Copy on Write gives it value type like behavior.
     * So they are quite similar to C++ vectors.
     */
    private var storage: [[HashTableNode]]
    private let lock: NSLock = NSLock()
    
    private var elementCount: Int
    private var loadFactor: Float {
        return Float(elementCount) / Float(storage.count)
    }
    
    // MARK: Public Getters
    public var count: Int {
        lock.lock()
        let readElementCount = elementCount
        lock.unlock()
        return readElementCount
    }
    
    public var capacity: Int {
        lock.lock()
        let readCapacity = storage.count
        lock.unlock()
        return readCapacity
    }
    
    // MARK: Public Init and API
    public init() {
        storage = Array(repeating: [], count: initialCapacity)
        elementCount = 0
    }
    
    /**
     * Inserts a new value and key in the HashTable or updates
     * the value for an existing key.
     */
    public func setValue(_ value: Value, for key: Key) {
        lock.lock()
        resizeStorageIfNeededUnsafeUnlocked()
        setValueForKeyInternalUnsafeUnlocked(value, for: key)
        lock.unlock()
    }
    
    /**
     * Returns the value for the given key or nil.
     */
    public func getValue(for key: Key) -> Value?
    {
        var readValue: Value? = nil
        lock.lock()
        let i = computeHashIndexUnsafeUnlocked(for: key)
        for j in 0..<storage[i].count {
            if storage[i][j].key == key {
                readValue = storage[i][j].value
                break
            }
        }
        lock.unlock()
        return readValue
    }
    
    /*
     * Deletes the value and key in the hashtable, returns the
     * value if present.
     */
    public func removeValue(for key: Key) -> Value?
    {
        var removedValue: Value? = nil
        lock.lock()
        let i = computeHashIndexUnsafeUnlocked(for: key)
        var foundIndex: Int?
        for j in 0..<storage[i].count {
            if storage[i][j].key == key {
                foundIndex = j
                break
            }
        }
        if let removeIndex = foundIndex {
            removedValue = storage[i][removeIndex].value
            storage[i].remove(at: removeIndex)
            elementCount -= 1
        }
        lock.unlock()
        return removedValue
    }
    
    // MARK: Private Helpers.
    //
    // Warning - None of these API's are thread safe and they directly mutate
    // shared state without acquiring a mutex. These API's should never be publicly
    // exposed and should only be called from a thread-safe call stack
    // (top level func should lock)
    private func setValueForKeyInternalUnsafeUnlocked(_ value: Value, for key: Key) {
        let i = computeHashIndexUnsafeUnlocked(for: key)
        var keyExists = false
        for j in 0..<storage[i].count {
            if storage[i][j].key == key {
                let node = HashTableNode(key: key, value: value)
                storage[i][j] = node
                keyExists = true
                break
            }
        }
        if !keyExists {
            let node = HashTableNode(key: key, value: value)
            storage[i].append(node)
            elementCount += 1
        }
    }
    
    private func computeHashIndexUnsafeUnlocked(for key: Key) -> Int
    {
        var hasher = Hasher()
        key.hash(into: &hasher)
        let hashCode = hasher.finalize()
        return abs(hashCode % storage.count)
    }
    
    private func resizeStorageIfNeededUnsafeUnlocked() {
        if loadFactor > alpha {
            let previousStorage = storage
            elementCount = 0
            storage = Array(repeating: [], count: previousStorage.count * 2)
            for i in 0..<previousStorage.count {
                for j in 0..<previousStorage[i].count {
                    setValueForKeyInternalUnsafeUnlocked(previousStorage[i][j].value, for: previousStorage[i][j].key)
                }
            }
        }
    }
}
