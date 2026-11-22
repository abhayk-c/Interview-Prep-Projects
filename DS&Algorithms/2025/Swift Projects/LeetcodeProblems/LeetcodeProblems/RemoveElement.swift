//
//  RemoveElement.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/3/26.
//

class RemoveElements {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var foundVal = false
        var writeIndex = 0
        var readIndex = 0
        for i in 0..<nums.count {
            if nums[i] == val {
                writeIndex = i
                readIndex = i+1
                foundVal = true
                break
            }
        }
        if !foundVal { return nums.count }
        while readIndex < nums.count {
            let currentVal = nums[readIndex]
            if currentVal == val {
                readIndex += 1
            } else {
                nums[writeIndex] = currentVal
                writeIndex += 1
                readIndex += 1
            }
        }
        let duplicateValueCount = nums.count - writeIndex
        nums.removeLast(duplicateValueCount)
        return nums.count
    }
}
