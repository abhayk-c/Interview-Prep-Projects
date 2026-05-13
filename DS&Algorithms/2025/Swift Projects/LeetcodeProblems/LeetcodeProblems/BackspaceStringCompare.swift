//
//  BackspaceStringCompare.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 4/10/26.
//

class BackspaceStringCompare {
    
    /**
     * Time Complexity: Linear time O(S + T) where S is the time to linearly scan s and t.
     * So its O(N) time, or linear time complexity. That being said we use O(S + T) additional space here,
     * the strings we build are essentially stacks.
     */
    func backspaceCompareUsingStack(_ s: String, _ t: String) -> Bool {
        var subStrOne: String = ""
        var subStrTwo: String = ""
        for char in s {
            if char != "#" {
                subStrOne.append(char)
            } else {
                _ = subStrOne.popLast()
            }
        }
        for char in t {
            if char != "#" {
                subStrTwo.append(char)
            } else {
                _ = subStrTwo.popLast()
            }
        }
        return subStrOne == subStrTwo
    }
    
    /**
     * Time Complexity: Linear time O(S + T) where S is the time to linearly scan s and t.
     * So its O(N) time, or linear time complexity.
     *
     * If we were in a language like C++ where you can directly iterate through a String with indices
     * like an array the benefit of this solution is we don't use any extra space here. So space complexity is O(1).
     */
    func backSpaceCompareUsingSlidingWindow(_ s: String, _ t: String) -> Bool {
        var sCharacterArray = Array(s)
        var tCharacterArray = Array(t)
        let sEnd = sanitizeByApplyingBackspaces(&sCharacterArray)
        let tEnd = sanitizeByApplyingBackspaces(&tCharacterArray)
        if sEnd == tEnd {
            var sReadIndex = 0
            var tReadIndex = 0
            while sReadIndex < sEnd {
                if sCharacterArray[sReadIndex] != tCharacterArray[tReadIndex] { return false }
                sReadIndex += 1
                tReadIndex += 1
            }
            return true
        }
        return false
    }
    
    private func sanitizeByApplyingBackspaces(_ characterArray: inout [Character]) -> Int {
        let len = characterArray.count
        var readIndex = 0
        var writeIndex = 0
        while readIndex < len {
            let currentChar = characterArray[readIndex]
            if currentChar == "#" {
                if writeIndex > 0 {
                    writeIndex -= 1
                }
                readIndex += 1
            } else {
                if writeIndex < readIndex {
                    characterArray[writeIndex] = characterArray[readIndex]
                }
                readIndex += 1
                writeIndex += 1
            }
        }
        return writeIndex
    }
}
