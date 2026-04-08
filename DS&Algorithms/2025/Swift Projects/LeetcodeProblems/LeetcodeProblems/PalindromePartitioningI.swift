//
//  PalindromePartitioning.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/7/25.
//

/*
 * This is the brute force recursive solution to the problem
 */
func computePalindromePartitions(_ s: String) -> [[String]]
{
    guard !s.isEmpty else { return [[String]]() }
    var allPartitions = [[String]]()
    let currentPartition = [String]()
    recursivelyComputePalindromePartitions(Array(s), currentPartition, &allPartitions, 0)
    return allPartitions
}

//There is definitely a way to do this with DP but you need to change the recursive approach a bit.
//I think it's worth optimizing and solving if you can.
func recursivelyComputePalindromePartitions(_ s: [Character],
                                            _ currentPartition: [String],
                                            _ allPartitions: inout [[String]],
                                            _ start: Int)
{
    if start >= s.count {
        allPartitions.append(currentPartition)
        return
    }
    for end in start..<s.count {
        if subStringIsPalindrome(s, start, end) {
            var nextPartition = currentPartition
            nextPartition.append(String(s[start...end]))
            recursivelyComputePalindromePartitions(s, nextPartition, &allPartitions, end+1)
        }
    }
}

func subStringIsPalindrome(_ s: [Character], _ subStrStart: Int, _ subStrEnd: Int) -> Bool
{
    var start = subStrStart
    var end = subStrEnd
    while start <= end {
        if s[start] != s[end] { return false }
        start += 1
        end -= 1
    }
    return true
}

