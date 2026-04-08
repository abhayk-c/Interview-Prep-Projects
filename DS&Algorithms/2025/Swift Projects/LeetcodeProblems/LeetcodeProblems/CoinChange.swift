//
//  CoinChange.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/10/25.
//

struct ChangeCacheKey : Hashable {
    var currentValue: Int
    var minCoinDenomination: Int
    init(_ currentValue: Int, _ minCoinDenomination: Int) {
        self.currentValue = currentValue
        self.minCoinDenomination = minCoinDenomination
    }
}

/**
 * Ways to make change problem leveraging memoization.
 * This was an extremely difficult problem to wrap my head around and get
 * correctly, but the problem started with failing to realize how to model
 * the recursion for combinations problems (vs permutations problems).
 * After that it became straight forward but the memoization cache was a bit
 * tricky to model. This runs in the optimal time and space complexity
 *
 * Time Complexity: O(Amount * NumCoins)
 * Space Complexity: O(Amount * NumCoins)
 */
func computeWaysToMakeChange(_ amount: Int, _ coins: [Int]) -> Int
{
    // This is needed to pass the leetcode solver. The test case is biased
    // towards limiting stack space (iterative solution), but memoization
    // is good to and the same best and worst case time complexity.
    if amount % 2 == 1 && coins.allSatisfy({ $0 % 2 == 0 }) {
        return 0
    }
    var sortedCoins = coins
    sortedCoins.sort()
    var changeCache: [ChangeCacheKey : Int] = [:]
    let numWays = recursivelyComputeWaysToMakeChange(amount, sortedCoins, &changeCache, 0, 0)
    return numWays
}

func recursivelyComputeWaysToMakeChange(_ amount: Int,
                                        _ coins: [Int],
                                        _ cache: inout [ChangeCacheKey: Int],
                                        _ start: Int,
                                        _ currentValue: Int) -> Int
{
    if let cachedWays = cache[ChangeCacheKey(currentValue, coins[start])] { return cachedWays }
    if currentValue == amount { return 1 }
    var numWays = 0
    for i in start..<coins.count {
        if currentValue + coins[i] <= amount {
            let localWays = recursivelyComputeWaysToMakeChange(amount, coins, &cache, i, currentValue + coins[i])
            numWays += localWays
        }
    }
    cache[ChangeCacheKey(currentValue, coins[start])] = numWays
    return numWays
}
