//
//  BitSet.swift
//  BitSet
//
//  Created by Abhay Curam on 9/30/25.
//

public struct BitSet {
    
    private let capacity: Int
    private var byteArray: [UInt8]
    
    public init(_ capacity: Int) {
        self.capacity = capacity
        let byteArrayCount = (capacity / 8) + 1
        self.byteArray = Array(repeating: 0, count: byteArrayCount)
    }
    
    public subscript(index: Int) -> Bool {
        get {
            guard index >= 0 && index < capacity else {
                assertionFailure("Index provided for BitSet out of bounds")
                return false
            }
            let mask: UInt8 = 1 << 7
            let byteIndex = index / 8
            let byte = byteArray[byteIndex]
            let bitPosition = index % 8
            let value = byte & (mask >> bitPosition)
            return (value == 0) ? false : true
        }
        set(newValue) {
            guard index >= 0 && index < capacity else {
                assertionFailure("Index provided for BitSet out of bounds")
                return
            }
            let mask: UInt8 = 1 << 7
            let byteIndex = index / 8
            var byte = byteArray[byteIndex]
            let bitPosition = index % 8
            byte = newValue ? (byte | (mask >> bitPosition)) : (byte & ~(mask >> bitPosition))
            byteArray[byteIndex] = byte
        }
    }
    
}
