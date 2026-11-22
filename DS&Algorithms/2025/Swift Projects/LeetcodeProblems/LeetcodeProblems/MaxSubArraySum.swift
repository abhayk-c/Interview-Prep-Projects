//
//  MaxSubArraySum.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/9/26.
//

class MaxSubArraySum {
    /**
     * O(N) time complexity solution with O(1) space.
     * This is Kadane's algorithm, its a greedy algorithm that requires a single pass.
     * This problem was tricky because it sounds like a sliding window problem on the surface
     * but it doesn't require a sliding window at all.
     */
    func maxSubArray(_ nums: [Int]) -> Int {
        var maxSum = 0
        var runningSum = 0
        for i in 0..<nums.count {
            runningSum = max(nums[i], runningSum + nums[i])
            if i == 0 {
                maxSum = runningSum
            } else if runningSum > maxSum {
                maxSum = runningSum
            }
        }
        return maxSum
    }
}
