//
//  LongestRepeatingSubString.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/25/25.
//

class LongestRepeatingSubString {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let characters = Array(s)
        var charToIndexMap: [Character : Int] = [:]
        var indexToCharMap: [Int : Character] = [:]
        var start = 0
        var end = 0
        var maxSubStringLength = 0
        while end < characters.count {
            let character = characters[end]
            if charToIndexMap[character] == nil {
                charToIndexMap[character] = end
                indexToCharMap[end] = character
                end += 1
            } else {
                if end - start > maxSubStringLength { maxSubStringLength = end - start }
                let repeatCharIndex = charToIndexMap[character]!
                resetDictionaryState(&charToIndexMap, &indexToCharMap, start, repeatCharIndex)
                start = repeatCharIndex + 1
            }
        }

        if end - start > maxSubStringLength { maxSubStringLength = end - start }
        return maxSubStringLength
    }

    func resetDictionaryState(_ charToIndexMap: inout [Character: Int],
                              _ indexToCharMap: inout [Int: Character],
                              _ startIndex: Int,
                              _ endIndex: Int)
    {
        for i in startIndex...endIndex {
            if let characterToDelete = indexToCharMap[i] {
                charToIndexMap[characterToDelete] = nil
                indexToCharMap[i] = nil
            }
        }
    }
}
