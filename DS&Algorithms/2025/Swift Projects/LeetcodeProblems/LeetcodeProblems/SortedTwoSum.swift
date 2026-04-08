//
//  SortedTwoSum.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/23/25.
//

class SortedTwoSum {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        guard !numbers.isEmpty else { return [] }
        var left = 0
        var right = numbers.count - 1
        while left < right {
            let leftValue = numbers[left]
            let rightValue = numbers[right]
            if leftValue + rightValue == target {
                return [left+1, right+1]
            } else if leftValue + rightValue < target {
                left += 1
            } else {
                right -= 1
            }
        }

        return []
    }
}
