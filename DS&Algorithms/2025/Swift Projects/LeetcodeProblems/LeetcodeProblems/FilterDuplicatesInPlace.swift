//
//  RemoveDuplicatesInPlace.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 6/15/25.
//

func filterDuplicatesInPlace(_ nums: inout [Int]) {
    // Lets do a in-place NLogN sort
    guard !nums.isEmpty else { return }
    nums.sort(by: {return $0 < $1})
    
    // Now we move all duplicates in-place to the back of the
    // array in a single pass.
    var index = 0
    while index < nums.count
            && index + 1 < nums.count
            && nums[index] != nums[index + 1] {
        index += 1
    }
    guard index < nums.count - 1 else { return }
    var writeIndex = index + 1
    var readIndex = index + 1
    var target = nums[writeIndex]
    while readIndex < nums.count {
        while readIndex < nums.count && nums[readIndex] <= target {
            readIndex += 1
        }
        if readIndex < nums.count {
            let temp = nums[writeIndex]
            nums[writeIndex] = nums[readIndex]
            nums[readIndex] = temp
            target = nums[writeIndex]
            writeIndex += 1
        }
    }
    
    //Now remove all elements from the end that are duplicates
    //which is still linear time since removing from end of array
    //is amortized O(1)
    nums.removeLast(nums.count - writeIndex)
}
