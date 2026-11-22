//
//  MinSubArraySum.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/10/26.
//

class MinSubArraySum {
    
    /**
     * Time Complexity is O(N) we find the min subArray in a single pass using sliding window.
     * In the worst case the same element can be added and removed to the window, this is roughly
     * saying we check each slot in the array twice.
     * So we make 2 passes, roughly O(2N) ~ O(N)
     */
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var minWindowLen = Int.max
        var currentSum = 0
        var left = 0
        var right = 0
        var movedRight = true
        while left < nums.count && right < nums.count {
            currentSum += movedRight ? nums[right] : -(nums[left-1])
            let currentWindowLen = right - left + 1
            if currentSum >= target && currentWindowLen < minWindowLen {
                minWindowLen = currentWindowLen
            }
            if left == right {
                guard right + 1 < nums.count else { break }
                right += 1
                movedRight = true
            } else {
                if currentSum - nums[left] < target {
                    guard right + 1 < nums.count else { break }
                    right += 1
                    movedRight = true
                } else {
                    left += 1
                    movedRight = false
                }
            }
        }
        
        return minWindowLen == Int.max ? 0 : minWindowLen
    }
}
