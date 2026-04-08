//
//  ListToInteger.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 4/7/26.
//

import Foundation

class ListToIntegerSolution {
    func getDecimalValue(_ head: ListNode?) -> Int {
        var length: Int = 0
        var cursor = head
        while cursor != nil {
            cursor = cursor?.next
            length += 1
        }
        length -= 1
        
        var totalValue = 0
        cursor = head
        while let unwrappedCursor = cursor {
            let multiplicand = pow(2, length)
            totalValue += (unwrappedCursor.val * (multiplicand as NSDecimalNumber).intValue)
            length -= 1
            cursor = cursor?.next
        }
        return totalValue
    }
}
