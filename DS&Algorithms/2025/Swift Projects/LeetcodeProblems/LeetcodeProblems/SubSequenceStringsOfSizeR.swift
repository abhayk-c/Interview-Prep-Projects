//
//  SubSequenceStringsOfSizeR.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/23/25.
//


/**
 * A word is a fine word if all subsequences of the word >= size 3
 * are valid words.
 */
func isSpecialWord(_ word: String, _ wordSet: Set<String>) -> Bool {
    guard word.count >= 3 else { return false }
    let distance = word.count - 3
    let upper = 3 + distance + 1
    for r in 3..<upper {
        let subsequences = subsequenceCombinationsWithDP(word, r)
        for subsequence in subsequences {
            if !wordSet.contains(subsequence) { return false }
        }
    }
    return true
}




func subsequenceCombinations(_ string: String, _ r: Int) -> [String] {
    var results: [String] = []
    recursivelyGenerateSubsequences(Array(string), 0, &results, "", r)
    return results
}

func recursivelyGenerateSubsequences(_ characterArray: [Character],
                                     _ startIndex: Int,
                                     _ results: inout [String],
                                     _ curSubsequence: String,
                                     _ size: Int) {
    if curSubsequence.count == size {
        results.append(curSubsequence)
        return
    }
    for i in startIndex..<characterArray.count {
        let currentChar = characterArray[i]
        var nextSubsequence = curSubsequence
        nextSubsequence.append(currentChar)
        recursivelyGenerateSubsequences(characterArray, i + 1, &results, nextSubsequence, size)
    }
    return
}

fileprivate struct SubsequenceCacheKey: Hashable {
    let index: Int
    let size: Int
}

func subsequenceCombinationsWithDP(_ string: String, _ r: Int) -> [String] {
    var cacheTable: [SubsequenceCacheKey : [String]] = [:]
    return recursivelyGenerateSubsequencesMemoized(Array(string), &cacheTable, 0, r)
}

fileprivate func recursivelyGenerateSubsequencesMemoized(_ characterArray: [Character],
                                                         _ cacheTable: inout [SubsequenceCacheKey : [String]],
                                                         _ currentIndex: Int,
                                                         _ currentSize: Int) -> [String] {
    if let cachedSubsequences = cacheTable[SubsequenceCacheKey(index: currentIndex, size: currentSize)] {
        return cachedSubsequences
    }
    if currentSize == 0 {
        return [""]
    }
    
    var results: [String] = []
    for i in currentIndex..<characterArray.count {
        let currentCharString = String(characterArray[i])
        let subsequences = recursivelyGenerateSubsequencesMemoized(characterArray, &cacheTable, i + 1, currentSize - 1)
        for subsequence in subsequences {
            results.append(currentCharString + subsequence)
        }
    }
    
    let cacheKey = SubsequenceCacheKey(index: currentIndex, size: currentSize)
    cacheTable[cacheKey] = results
    return results
}
