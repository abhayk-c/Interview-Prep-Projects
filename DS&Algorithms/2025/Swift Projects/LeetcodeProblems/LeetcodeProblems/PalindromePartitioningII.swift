//
//  PalindromePartitioningII.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/8/25.
//

/*
 * This solution leverages dynamic programming (Memoization) to optimize
 * the solution and move it to the best possible time complexity, trading off
 * space complexity. By employing memoization we sped up the solution by 50% (2x)
 * compared to brute force.
 */
func computePalindromeDecompositions(_ s: String) -> [[String]]
{
    guard !s.isEmpty else { return [[String]]() }
    var decompositionsCache = [Int : [[String]]]()
    return recursivelyComputePalindromeDecompositions(Array(s), &decompositionsCache, 0)
}

func recursivelyComputePalindromeDecompositions(_ s: [Character],
                                                _ decompositionsCache: inout [Int : [[String]]],
                                                _ start: Int) -> [[String]]
{
    if let cachedDecompositions = decompositionsCache[start] {
        return cachedDecompositions
    }
    if start == s.count - 1 {
        let baseDecomposition = [[String(s[start])]]
        decompositionsCache[start] = baseDecomposition
        return baseDecomposition
    }
    
    var currentDecompositions = [[String]]()
    for end in start..<s.count {
        if subStrIsPalindrome(s, start, end) {
            let decompositions = recursivelyComputePalindromeDecompositions(s, &decompositionsCache, end+1)
            let localDecompositions = makeLocalDecompositions(String(s[start...end]), decompositions)
            for local in localDecompositions { currentDecompositions.append(local) }
        }
    }
    decompositionsCache[start] = currentDecompositions
    return currentDecompositions
}

func makeLocalDecompositions(_ subStr: String, _ decompositions: [[String]]) -> [[String]]
{
    guard !decompositions.isEmpty else { return [[subStr]] }
    var results = [[String]]()
    for var decomposition in decompositions {
        decomposition.insert(subStr, at: 0)
        results.append(decomposition)
    }
    return results
}

func subStrIsPalindrome(_ s: [Character], _ subStrStart: Int, _ subStrEnd: Int) -> Bool
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
