//
//  Levens.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/12/25.
//

/**
 * I came up with my own top-down memoization DP solution to solving the Levenshtein
 * Distance problem. The recursive rules, base cases, and everything was exactly spot
 * on for the algorithm. The time complexity and space complexity is the best that it can
 * be O(NM) where N is size of word1 and M is size of word2.
 *
 * One thing I could do to optimize the solution is to just work with indexes instead of
 * new copies of strings each time in the recursion. Editing the string and passing
 * a copy is actually not needed because you can simulate edits by just moving the index.
 * This would make my cache simpler too (cache indices as opposed to a string key).
 */
func computeWordDistance(_ word1: String, _ word2: String) -> Int
{
    var minDistanceCache  = [String : Int]()
    return recursivelyComputeLevenshteinDistance(Array(word1), Array(word2), &minDistanceCache, 0)
}

func recursivelyComputeLevenshteinDistance(_ word1: [Character],
                                           _ word2: [Character],
                                           _ minDistanceCache: inout [String : Int],
                                           _ start: Int) -> Int
{
    //First check our min distance cache
    let cacheKey = getDistanceCacheKey(word1, word2)
    if let cachedDistance = minDistanceCache[cacheKey] { return cachedDistance }
    
    //Now we scan until characters are no longer equal and process our bases cases.
    var scanIndex = start
    while scanIndex < word1.count && scanIndex < word2.count {
        if word1[scanIndex] != word2[scanIndex] { break }
        scanIndex += 1
    }
    if scanIndex > word1.count - 1 && scanIndex > word2.count - 1 {
        // words perfectly transformed (exact match)
        minDistanceCache[cacheKey] = 0
        return 0
    }
    if scanIndex > word1.count - 1 && scanIndex < word2.count {
        // (batch insertion) words transformed but different lengths
        minDistanceCache[cacheKey] = word2.count - word1.count
        return word2.count - word1.count
    }
    if scanIndex > word2.count - 1 && scanIndex < word1.count {
        // (batch deletion) words transformed but different lengths
        minDistanceCache[cacheKey] = word1.count - word2.count
        return word1.count - word2.count
    }
    
    // Apply character substitution and recurse
    var substitutionTransform = word1
    substitutionTransform[scanIndex] = word2[scanIndex]
    let substitutionMinDistance = 1 + recursivelyComputeLevenshteinDistance(substitutionTransform, word2, &minDistanceCache, scanIndex)
    
    // Apply character insertion and recurse
    var insertionTransform = word1
    insertionTransform.insert(word2[scanIndex], at: scanIndex)
    let insertionMinDistance = 1 + recursivelyComputeLevenshteinDistance(insertionTransform, word2, &minDistanceCache, scanIndex)
    
    // Apply character deletion and recurse
    var deletionTransform = word1
    deletionTransform.remove(at: scanIndex)
    let deletionMinDistance = 1 + recursivelyComputeLevenshteinDistance(deletionTransform, word2, &minDistanceCache, scanIndex)
    
    let minDistance = min(substitutionMinDistance, insertionMinDistance, deletionMinDistance)
    minDistanceCache[cacheKey] = minDistance
    return minDistance
}

func getDistanceCacheKey(_ word1: [Character], _ word2: [Character]) -> String
{
    return "\(String(word1)):\(String(word2))"
}

