//
//  ClimbStairs.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/8/25.
//

/**
 * Bottom up DP solution running in O(nk) time complexity and
 * O(N) space.
 */
func climbStairs(_ n: Int, _ k: Int) -> Int
{
    guard n > 0 && k > 0 else { return 0 }
    var stepsTable: [Int] = Array(repeating: 0, count: n+1)
    stepsTable[n] = 1
    for i in (0..<n).reversed() {
        var numWays = 0
        for j in 1..<k+1 {
            if i + j < stepsTable.count {
                numWays += stepsTable[i + j]
            }
        }
        stepsTable[i] = numWays
    }
    return stepsTable[0]
}


/*
 * This is a top down recursive DP algorithm (memoization) to count
 * number of ways to climb n stairs with k steps at a time. The algorithm runs
 * in O(nk) time complexity and O(n) space. For the climb stairs problem we
 * cant do better than O(nk) time and O(n) space. Its really O(2N) space because
 * the recursive call stack uses O(n) and the memoization cache uses O(N)
 */
func numWaysToClimbStairs(_ n: Int, _ k: Int) -> Int
{
    guard n > 0 && k > 0 else { return 0 }
    var cache: [Int] = Array(repeating: -1, count: n+1)
    return recursivelyComputeNumWaysToClimbStairs(0, n, k, &cache)
}

func recursivelyComputeNumWaysToClimbStairs(_ currentStep: Int,
                                            _ numSteps: Int,
                                            _ k: Int,
                                            _ cache: inout [Int]) -> Int
{
    if currentStep > numSteps { return 0 }
    if currentStep == numSteps { return 1 }
    if cache[currentStep] != -1 { return cache[currentStep] }
    var numWays = 0
    for i in 1..<k+1 {
        numWays += recursivelyComputeNumWaysToClimbStairs(currentStep + i, numSteps, k, &cache)
    }
    cache[currentStep] = numWays
    return numWays
}
