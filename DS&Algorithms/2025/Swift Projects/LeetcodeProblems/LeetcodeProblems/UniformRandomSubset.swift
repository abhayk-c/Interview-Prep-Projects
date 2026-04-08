//
//  UniformRandomSubset.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 5/24/25.
//

/**
 * This is a solution for the Sample Offline Data problem in EIP book (5.12).
 * My solution is nothing but a partial Fisher-Yates shuffle algo.
 * As a result it can be used to Shuffle a deck of cards so I provide
 * a solution for that below which was a Leetcode problem.
 */
func uniformRandomSubset<Element: Any>(_ elems: inout [Element],
                                       _ subsetSize: Int) -> [Element]
{
    var elements = elems //lets make a fresh copy first.
    guard subsetSize > 0 && subsetSize <= elements.count else { return [] }
    var k = 0
    while k < subsetSize {
        let index = Int.random(in: 0..<elements.count)
        let temp = elements[elements.count - k - 1]
        elements[elements.count - k - 1] = elements[index]
        elements[index] = temp
        k += 1
    }
    var subset = [Element]()
    var i = elements.count - k
    while i < elements.count {
        subset.append(elements[i])
        i += 1
    }
    return subset
}

/**
 * Uses the above method to shuffle a deck of cards.
 * Leetcode Problem: https://leetcode.com/problems/shuffle-an-array/
 */
class Solution {
    
    private var _nums: [Int]

    init(_ nums: [Int]) {
        _nums = nums
    }
    
    func reset() -> [Int] {
        return _nums
    }
    
    func shuffle() -> [Int] {
        return randomSubset(&_nums, _nums.count)
    }
    
    private func randomSubset<Element: Any>(_ elems: inout [Element],
                                       _ subsetSize: Int) -> [Element]
    {
        var elements = elems //lets make a fresh copy first.
        guard subsetSize > 0 && subsetSize <= elements.count else { return [] }
        var k = 0
        while k < subsetSize {
            let index = Int.random(in: 0..<elements.count)
            let temp = elements[elements.count - k - 1]
            elements[elements.count - k - 1] = elements[index]
            elements[index] = temp
            k += 1
        }
        var subset = [Element]()
        var i = elements.count - k
        while i < elements.count {
            subset.append(elements[i])
            i += 1
        }
        return subset
    }
}
