//
//  MyHashMap.swift
//  HashTable
//
//  Created by Abhay Curam on 5/15/25.
//

//
//  HashTable.swift
//  HashTable
//
//  Created by Abhay Curam on 5/15/25.
//

/**
 * This is the leetcode wrapper around the HashTable.
 *
 * https://leetcode.com/problems/design-hashmap/description/
 */
class MyHashMap {

    private var hashTable: HashTable<Int, Int>
    
    init() {
        hashTable = HashTable<Int, Int>()
    }
    
    func put(_ key: Int, _ value: Int) {
        hashTable.setValue(value, for: key)
    }
    
    func get(_ key: Int) -> Int {
        if let value = hashTable.getValue(for: key) {
            return value
        }
        return -1
    }
    
    func remove(_ key: Int) {
        _ = hashTable.removeValue(for: key)
    }
}
