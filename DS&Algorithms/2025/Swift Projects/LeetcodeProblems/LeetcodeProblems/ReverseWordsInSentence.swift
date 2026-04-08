//
//  ReverseWordsInSentence.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 5/21/25.
//

/**
 * Problem 6.6 in Elements of Programming Interviews.
 * These problems are also on leetcode and there are two variants
 * of the problem, one to do it using O(N) space, and one without (in-place)
 */

/*
 * By leveraging a stack (array stack) this algorithm reverses the words
 * in a sentence in O(N) time using additional O(N) space.
 */
func reverseWordsInSentence(_ sentence: String) -> String
{
    var stack: [Character] = []
    var reversedString = ""
    for character in sentence.reversed() {
        if character != " " {
            if stack.isEmpty {
                stack.append(" ")
            }
            stack.append(character)
        } else {
            fillStringFromStack(&stack, &reversedString)
        }
    }
    fillStringFromStack(&stack, &reversedString)
    _ = reversedString.popLast()
    return reversedString
}

func fillStringFromStack(_ stack: inout [Character],
                         _ reversedString: inout String)
{
    while let stackCharacter = stack.popLast() {
        reversedString.append(stackCharacter)
    }
}

/**
 * A variant of the problem that reverses words "in-place" using
 * a Character array. O(N) time and O(1) space.
 */
func reverseWordsInPlace(_ str: inout [Character])
{
    guard !str.isEmpty else { return }
    reverseSubStr(&str, 0, str.count - 1)
    var leftIndex = 0
    var rightIndex = 0
    while leftIndex < str.count {
        while rightIndex < str.count && str[rightIndex] != " " {
            rightIndex += 1
        }
        reverseSubStr(&str, leftIndex, rightIndex - 1)
        rightIndex += 1
        leftIndex = rightIndex
    }
}

func reverseSubStr(_ subStr: inout [Character], _ start: Int, _ end: Int)
{
    var startIndex = start
    var endIndex = end
    while startIndex < endIndex {
        let temp = subStr[startIndex]
        subStr[startIndex] = subStr[endIndex]
        subStr[endIndex] = temp
        startIndex += 1
        endIndex -= 1
    }
}
