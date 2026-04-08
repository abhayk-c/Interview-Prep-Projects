//
//  main.swift
//  HashTable
//
//  Created by Abhay Curam on 5/15/25.
//

import Foundation


let map = HashTable<Int, Int>()
map.setValue(1, for: 1)
map.setValue(2, for: 2)
print(map.getValue(for: 1) ?? -1)
print(map.getValue(for: 3) ?? -1)
map.setValue(2, for: 1)
print(map.getValue(for: 2) ?? -1)
print(map.removeValue(for: 2) ?? -1)

// ["MyHashMap","remove","get","put","put",   "put","get","put","put","put","put"]
// [[],           [14],    [4],[7,3],[11,1],[12,1],  [7],[1,19],[0,3],[1,8],[2,6]]

let hashMap = MyHashMap()
hashMap.remove(14)
print(hashMap.get(4))
hashMap.put(7, 3)
hashMap.put(11, 1)
hashMap.put(12, 1)
print(hashMap.get(7))
hashMap.put(1, 19)
hashMap.put(0, 3)
hashMap.put(1, 8)
hashMap.put(2, 6)

// ["MyHashMap","put","put","get","get","put","get","remove","get"]
// [    [],     [1,1],[2,2], [1],  [3], [2,1], [2],    [2],   [2]]
let hashMap2 = MyHashMap()
hashMap2.put(1, 1)
hashMap2.put(2, 2)
_ = hashMap2.get(1)
_ = hashMap2.get(3)
hashMap2.put(2, 1)
_ = hashMap2.get(2)
hashMap2.remove(2)
_ = hashMap2.get(2)

//Testing Write Storm

threadSafeMap = HashTable<String, Int>()
DispatchQueue.concurrentPerform(iterations: 100000) { index in
    threadSafeMap.setValue(index, for: String(index))
}

print("Dictionary count: \(threadSafeMap.count)")
print("Dictionary capacity: \(threadSafeMap.capacity)")
print("Printing Keys and Values:")
for i in 0..<100000 {
    let key = String(i)
    let value = threadSafeMap.getValue(for: key)
    print("Key: \(key), Value: \(value ?? -1)")
}

print("---------------------")
print("---------------------")


//Testing Interleaved Writes and Reads
var threadSafeMap = HashTable<String, Int>()
DispatchQueue.concurrentPerform(iterations: 100000) { index in
    if index % 2 == 0 {
        threadSafeMap.setValue(index, for: String(index))
    } else {
        let randIndex = Int.random(in: 0..<100000)
        let key = String(randIndex)
        let value = threadSafeMap.getValue(for: key)
        print("Key: \(key), Value: \(value ?? -1)")
    }
}
print("Dictionary count: \(threadSafeMap.count)")
print("Dictionary capacity: \(threadSafeMap.capacity)")
print("Printing Keys and Values:")
for i in 0..<100000 {
    let key = String(i)
    let value = threadSafeMap.getValue(for: key)
    print("Key: \(key), Value: \(value ?? -1)")
}

print("---------------------")
print("---------------------")

//Testing Interleaved Writes and Removals
DispatchQueue.concurrentPerform(iterations: 100000) { index in
    if index % 2 == 0 {
        _ = threadSafeMap.removeValue(for: String(index))
    } else {
        threadSafeMap.setValue(index, for: String(index))
    }
}
print("Dictionary count: \(threadSafeMap.count)")
print("Dictionary capacity: \(threadSafeMap.capacity)")
print("Printing Keys and Values:")
for i in 0..<100000 {
    let key = String(i)
    let value = threadSafeMap.getValue(for: key)
    print("Key: \(key), Value: \(value ?? -1)")
}


