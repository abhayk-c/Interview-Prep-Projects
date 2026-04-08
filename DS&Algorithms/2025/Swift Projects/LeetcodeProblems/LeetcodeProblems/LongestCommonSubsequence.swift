//
//  LongesCommonSubsequence.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/29/25.
//

/**
 * Not passing test cases unfortunately. Will need to debug this further. Good exercise though.
 * I think your cache implementation is somewhat broken and the main problem. May be a good idea to just read
 * the solution as well.
 */
class LongestCommonSubsequence {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> String {
        let text1Characters = Array(text1)
        let text2Characters = Array(text2)
        var largerTextRun: [Character] = []
        var smallerTextRun: [Character] = []
        var characterIndexMap: [Character : [Int]] = [:]
        if text1Characters.count > text2Characters.count {
            largerTextRun = text1Characters
            smallerTextRun = text2Characters
        } else {
            largerTextRun = text2Characters
            smallerTextRun = text1Characters
        }
        for i in 0..<largerTextRun.count {
            let curChar = largerTextRun[i]
            if characterIndexMap[curChar] == nil {
                characterIndexMap[curChar] = [i]
            } else {
                characterIndexMap[curChar]?.append(i)
            }
        }

        var subsequenceCache: [String : String] = [:]
        let result = recursivelyComputeLongestCommonSubsequence(-1, -1, &smallerTextRun, &subsequenceCache, &characterIndexMap)
        return result
    }

    func recursivelyComputeLongestCommonSubsequence(_ start: Int,
                                                    _ curr: Int,
                                                    _ text: inout [Character],
                                                    _ subsequenceCache: inout [String : String],
                                                    _ characterIndexMap: inout [Character : [Int]]) -> String
    {
        if let cachedSubsequence = subsequenceCache["\(start),\(curr)"] {
            return cachedSubsequence
        }
        if start + 1 == text.count {
            let result = String(text[start])
            subsequenceCache["\(start),\(curr)"] = result
            return result
        }
        let lower = start + 1
        var maxSubsequenceLen = 0
        var longestSubsequence = ""
        for i in lower..<text.count {
            let curChar = text[i]
            if let indices = characterIndexMap[curChar] {
                var characterIndex = -1
                for index in indices {
                    if index > curr {
                        characterIndex = index
                        break
                    }
                }
                if characterIndex != -1 {
                    let localSubsequence = recursivelyComputeLongestCommonSubsequence(i, characterIndex, &text, &subsequenceCache, &characterIndexMap)
                    if localSubsequence.count > maxSubsequenceLen {
                        maxSubsequenceLen = localSubsequence.count
                        longestSubsequence = localSubsequence
                    }
                }
            }
        }

        let result = (start > -1) ? String(text[start]) + longestSubsequence : longestSubsequence
        subsequenceCache["\(start),\(curr)"] = result
        return result
    }

}
