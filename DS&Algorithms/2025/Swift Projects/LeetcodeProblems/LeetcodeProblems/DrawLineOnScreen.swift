//
//  DrawLine.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/13/25.
//

public func drawLine(_ bytes: inout [UInt8], _ width: Int, _ x1: Int, _ x2: Int, _ y: Int)
{
    let offset = (width >> 3) * y
    var lower = x1
    while lower <= x2 {
        let currentByteIndex = offset + (lower >> 3)
        guard currentByteIndex < bytes.count else {
            assertionFailure("Byte index out of bounds, invalid screen dimensions or x,y coordinates provided")
            return
        }
        let currentByte = bytes[currentByteIndex]
        let bitPosition = lower % 8
        var maskSize = x2 - lower + 1
        if maskSize > 8 {
            maskSize = 8 - bitPosition
        }
        var mask: UInt8 = ~0
        mask = mask >> (8 - maskSize)
        mask = mask << (8 - maskSize - bitPosition)
        let modifiedByte = currentByte | mask
        bytes[currentByteIndex] = modifiedByte
        lower += 8 - bitPosition
    }
}
