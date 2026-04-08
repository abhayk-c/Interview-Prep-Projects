//
//  PeakAndValleySort.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 6/16/25.
//

/*
 * Algorithm for sorting an array of numbers into peaks and valley's
 * Elements of Programming Interviews Problem. I came up with my own solution
 * but its optimal and runs in the same time complexity of the book.
 * I leveraged a two pointer technique taking advantage of the sorted array
 * to arrange the peaks and valleys by laying out the extrema at each index
 * (alternating between min and max)
 * 
 * Time Complexity is O(NLogN + N) ~ O(NlogN)
 * Space Complexity is O(N)
 *
 */
func peakAndValleySort(_ nums: inout [Int]) -> [Int]
{
    nums.sort()
    var result: [Int] = Array(repeating: 0, count: nums.count)
    var i = 0
    var valley = 0
    var peak = nums.count - 1
    var isValley = true
    while valley <= peak {
        if isValley {
            result[i] = nums[valley]
            valley += 1
        } else {
            result[i] = nums[peak]
            peak -= 1
        }
        isValley = !isValley //flip
        i += 1
    }
    return result
}
