//
//  IsPowerOf2.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/13/25.
//

func isPowerOfTwo(_ n: Int) -> Bool {
    var num = n
    let mask: Int = 1
    var oneSetFlag = false
    for index in 0..<32 {
        num = (index == 0) ? num : (num >> 1)
        if (num & mask) == 1 {
            if oneSetFlag {
                return false
            } else {
                oneSetFlag = true
            }
        }
    }
    return true
}
