//
//  ParanthesesValidator.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 4/8/26.
//

class ParenthesesValidator {
    func isValid(_ s: String) -> Bool {
        let openParens: Set<Character> = ["(", "{", "["]
        let closeParens: Set<Character> = [")", "}", "]"]
        let closeParensMap: [Character : Character] = [")":"(", "}":"{", "]":"["]
        var parserStack: [Character] = []
        for char in s {
            if openParens.contains(char) {
                parserStack.append(char)
            } else if closeParens.contains(char) {
                if let recentParen = parserStack.last {
                    if recentParen == closeParensMap[char] ?? Character("") {
                        parserStack.removeLast()
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        return parserStack.isEmpty
    }
}
