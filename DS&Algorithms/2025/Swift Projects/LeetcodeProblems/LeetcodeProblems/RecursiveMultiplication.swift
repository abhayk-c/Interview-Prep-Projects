//
//  RecursiveMultiplication.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/3/25.
//

/*
 * Multiplies without using multiplication by bitshifting and adding.
 */
func multiplyWithoutUsingMultiplicationOperator(x: Int, y: Int) -> Int
{
    guard x >= 0 && y >= 0 else { return -1 }
    if x == 0 || y == 0 { return 0 }
    var product = max(x, y)
    recursiveMultiply(max(x,y), min(x,y), 1, &product)
    return product
}

func recursiveMultiply(_ multiplicand: Int, _ multiplier: Int, _ times: Int, _ product: inout Int)
{
    if times == multiplier { return }
    if (times + times) <= multiplier {
        product = product << 1
        recursiveMultiply(multiplicand, multiplier, times + times, &product)
    } else {
        product += multiplicand
        recursiveMultiply(multiplicand, multiplier, times + 1, &product)
    }
}

/*
 * Multiplies without using multiplication by bitshifting. This one adds an
 * optimization to see if we should move to 2^N+1 place and subtract instead of
 * stopping at 2^N and adding. Depending on where those fall on number line one may
 * be more efficeint than other.
 *
 * The time complexity of this solution in O(LogN) in the average case but O(N) in the
 * worst case. The book's solution is more optimal, O(LogN) in average and worst case.
 * That being said this is better than the brute force O(N) solution.
 */
func multiplyWithoutUsingMultiplicationOperatorOptimized(x: Int, y: Int) -> Int
{
    guard x >= 0 && y >= 0 else { return -1 }
    if x == 0 || y == 0 { return 0 }
    var product = max(x, y)
    recursiveMultiplyOptimized(max(x,y), min(x,y), 1, &product, false)
    return product
}

func recursiveMultiplyOptimized(_ multiplicand: Int,
                                _ multiplier: Int,
                                _ times: Int,
                                _ product: inout Int,
                                _ stoppedBitShifting: Bool)
{
    if times == multiplier { return }
    if !stoppedBitShifting && (times + times) <= multiplier {
        product = product << 1
        recursiveMultiplyOptimized(multiplicand, multiplier, times + times, &product, stoppedBitShifting)
    } else {
        if !stoppedBitShifting {
            let leftDistance = abs(multiplier - times)
            let rightDistance = abs((times + times) - multiplier)
            if leftDistance < rightDistance {
                product += multiplicand
                recursiveMultiplyOptimized(multiplicand, multiplier, times + 1, &product, true)
            } else {
                product = product << 1
                recursiveMultiplyOptimized(multiplicand, multiplier, times + times, &product, true)
            }
        } else {
            if times > multiplier {
                product -= multiplicand
                recursiveMultiplyOptimized(multiplicand, multiplier, times - 1, &product, stoppedBitShifting)
            } else {
                product += multiplicand
                recursiveMultiplyOptimized(multiplicand, multiplier, times + 1, &product, stoppedBitShifting)
            }
        }
    }
}

