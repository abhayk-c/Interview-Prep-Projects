//
//  FilterDuplicates.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 5/23/25.
//

/**
 * I came up with my own novel solution to this problem that passed LeetCode
 * test cases and had linear time complexity. The algorithm is more of a
 * memory compactness algorithm according to Leetcode but it works for this problem.
 * My idea was to first tombstone/mark duplicate values in a single pass, and use these
 * to identify contiguous empty blocks. Then in a second pass I pull non-duplicate elements
 * forward into the array by using a sliding swap window technique. Implementing it this way
 * was pretty challenging, there is a much simpler two pointer (read and write pointer)
 * solution to this problem..
 * According to ChatGPT my algorithm is how Garbage collectors work, tombstoning/invalidating
 * memory and then compacting memory blocks in a second pass.
 */
func removeDuplicates(_ nums: inout [Int]) -> Int
{
    guard !nums.isEmpty else { return 0 }
    let filteredCount = nums.count - markDuplicates(&nums)
    filterOutDuplicates(&nums)
    return filteredCount
}

func markDuplicates(_ nums: inout [Int]) -> Int
{
    let kEmptySpace = -101
    var duplicateCount = 0
    var previousValue = 0
    for i in 0..<nums.count {
        if i == 0 {
            previousValue = nums[i]
        } else {
            if nums[i] == previousValue {
                nums[i] = kEmptySpace
                duplicateCount += 1
            } else {
                previousValue = nums[i]
            }
        }
    }
    return duplicateCount
}

func filterOutDuplicates(_ nums: inout [Int])
{
    var index = 0
    var swapWindowSize = 0
    let kEmptySpace = -101
    while index < nums.count {
        if nums[index] == kEmptySpace {
            /*
             * Jump by swap window size cus first we are looking for more
             * spaces, the current swapWindow is ALWAYS present so we build on it
             * and going through the old window is wasteful. We know its empty spaces.
             */
            var left = index + swapWindowSize
            var spaceCount = 0
            while left < nums.count && nums[left] == kEmptySpace {
                left += 1
                spaceCount += 1
            }
            //While expanding our swap window and searching for more empty entries
            //if we went out of the bounds of the array we have no more elements left to swap.
            if left >= nums.count { break }
            //update swap window size if we found new empty entries.
            swapWindowSize += spaceCount
            //Shift left back by the swap window to prepare for swapping elements.
            left -= swapWindowSize
            //Set right to the first element after the swap window (window of empty spaces).
            var right = left + swapWindowSize
            //If right is larger than our array bounds we have no more elements left to swap
            if right >= nums.count { break }
            
            //Begin loop to swap as many elements as we can.
            let leftBoundary = left + swapWindowSize
            while left < leftBoundary && left < nums.count && right < nums.count {
                if nums[right] == kEmptySpace { break }
                let temp = nums[right]
                nums[right] = nums[left]
                nums[left] = temp
                left += 1
                right += 1
            }
            
            /*
             * Set our loop index to left. This will always point to an empty field
             * and represents the logical beginning of our sliding swap window for
             * the next iteration. Setting it to right will skip elements to swap.
             */
            index = left
        } else {
            index += 1
        }
    }
}
