//
//  main.swift
//  AccessControlFun
//
//  Created by Abhay Curam on 5/16/25.
//

import Foundation

print("Hello, World!")

var visitedIndexSet = Set<Int>()

class CacheEntry {
    let x: Int
    let y: Int
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

func main() {
    /**
     * CacheEntry object instance is initially created giving CacheEntry object
     * a retain count of 1. Then the object instance is assigned to a local "strong"
     * variable cacheEntry which bumps up CacheEntry's retain count to 2.
     * After CacheEntry constructor called, CacheEntry itself goes out of scope
     * decrementing the retain count to 1. RetainCount of cacheEntry remains 1
     * until cacheEntry itself goes out scope.
     *
     * ARC implements a compile optimization called retain/release elision so
     * that the retain count is always 1 here. It sees the object is being assigned
     * to a strong variable and just keeps the retain count at 1 to avoid two RC increments
     * and a decrement. But its useful to think about it the way I described above.
     */
    let cacheEntry = CacheEntry(x: 3, y: 4)
    
}
// main() goes out of scope, so cacheEntry goes out of scope. Drops retain count to 0 and memory dealloced.




/*
 var tupleCache: [CacheEntry : String] = [:]
 tupleCache[CacheEntry(x: 2, y: 5)] = "hello"
 tupleCache[CacheEntry(x: 5, y: 2)] = "world"
 print("end")\
 print("end")
 */
