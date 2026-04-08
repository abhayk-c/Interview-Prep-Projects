import UIKit
import Foundation

func climbStairsBottomUpDP(_ n: Int) -> Int {
    guard n >= 2 else { return n }
    var stepTable: [Int] = Array(repeating: 0, count: n+1)
    stepTable[0] = 1
    stepTable[1] = 1
    var curStep = 2
    while curStep <= n {
        stepTable[curStep] = stepTable[curStep - 2] + stepTable[curStep - 1]
        curStep += 1
    }
    return stepTable[curStep - 1]
}

func climbStairsMemoization(_ n: Int) -> Int {
    var cache: [Int] = Array(repeating: -1, count: n+1)
    var numWays = computeNumWaysToClimbStairs(n, &cache)
    return numWays
}

func computeNumWaysToClimbStairs(_ n: Int, _ cache: inout [Int]) -> Int {
    if n < 0 { return 0 }
    if n == 0 { return 1 }
    if cache[n] != -1 {
        return cache[n]
    }
    let numWays = computeNumWaysToClimbStairs(n-2, &cache) + computeNumWaysToClimbStairs(n-1, &cache)
    cache[n] = numWays
    return numWays
}


func climbStairs(_ n: Int) -> Int {
    if n < 0 { return 0 }
    if n == 0 { return 1 }
    return climbStairs(n - 1) + climbStairs(n - 2)
}


print(climbStairs(1))
print(climbStairs(2))
print(climbStairs(3))
print(climbStairs(4))
print(climbStairs(5))
print(climbStairs(6))
print(climbStairs(7))
print(climbStairs(8))
print(climbStairs(9))
print(climbStairs(10))
print(climbStairs(11))
print(climbStairs(12))
print(climbStairs(13))
print(climbStairs(14))
print(climbStairs(15))
print(climbStairs(20))

print(climbStairsMemoization(1))
print(climbStairsMemoization(2))
print(climbStairsMemoization(3))
print(climbStairsMemoization(4))
print(climbStairsMemoization(5))
print(climbStairsMemoization(6))
print(climbStairsMemoization(7))
print(climbStairsMemoization(8))
print(climbStairsMemoization(9))
print(climbStairsMemoization(10))
print(climbStairsMemoization(11))
print(climbStairsMemoization(12))
print(climbStairsMemoization(13))
print(climbStairsMemoization(14))
print(climbStairsMemoization(15))
print(climbStairsMemoization(20))
print(climbStairsMemoization(80))

print(climbStairsBottomUpDP(1))
print(climbStairsBottomUpDP(2))
print(climbStairsBottomUpDP(3))
print(climbStairsBottomUpDP(4))
print(climbStairsBottomUpDP(5))
print(climbStairsBottomUpDP(6))
print(climbStairsBottomUpDP(7))
print(climbStairsBottomUpDP(8))
print(climbStairsBottomUpDP(9))
print(climbStairsBottomUpDP(10))
print(climbStairsBottomUpDP(11))
print(climbStairsBottomUpDP(12))
print(climbStairsBottomUpDP(13))
print(climbStairsBottomUpDP(14))
print(climbStairsBottomUpDP(15))
print(climbStairsBottomUpDP(20))
print(climbStairsBottomUpDP(80))

let clock = ContinuousClock()
let resultTwo = clock.measure {
    print(climbStairsMemoization(80))
}

let resultThree = clock.measure {
    print(climbStairsBottomUpDP(80))
}

print(resultTwo)
print(resultThree)
