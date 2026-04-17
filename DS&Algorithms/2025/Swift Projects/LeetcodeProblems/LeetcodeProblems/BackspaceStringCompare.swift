//
//  BackspaceStringCompare.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 4/10/26.
//

/**
 * Time Complexity: Linear time O(S + T) where S is the time to linearly scan s and t.
 * So its O(N) time, or linear time complexity.
 */
class BackspaceStringCompare {
    func backspaceCompare(_ s: String, _ t: String) -> Bool {
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
}
