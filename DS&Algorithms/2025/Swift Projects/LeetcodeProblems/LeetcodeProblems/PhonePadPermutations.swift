//
//  PhonePadPermutations.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/15/25.
//

class PhonePadPermutations {
    func letterCombinations(_ digits: String) -> [String] {
        var phonePad: [Character : [Character]] = ["2" : ["a","b","c"],
                                                   "3" : ["d","e","f"],
                                                   "4" : ["g","h","i"],
                                                   "5" : ["j","k","l"],
                                                   "6" : ["m","n","o"],
                                                   "7" : ["p","q","r","s"],
                                                   "8" : ["t","u","v"],
                                                   "9" : ["w","x","y","z"]]
        var digitsArray = Array(digits)
        var letterCombinationsTable: [Int : [String]] = [:]
        return computeLetterCombinations(&digitsArray, 0, &phonePad, &letterCombinationsTable)
    }

    private func computeLetterCombinations(_ digits: inout [Character],
                                           _ index: Int,
                                           _ phonePad: inout [Character : [Character]],
                                           _ letterCombinationsTable: inout [Int : [String]]) -> [String]
    {
        if index > digits.count - 1 {
            return [""]
        }
        if let cachedCombinations = letterCombinationsTable[index] {
            return cachedCombinations
        }
        let currentDigit = digits[index]
        let currentDigitCharacters = phonePad[currentDigit]
        var currentCombinations: [String] = []
        for character in currentDigitCharacters! {
            let subCombinations = computeLetterCombinations(&digits, index+1, &phonePad, &letterCombinationsTable)
            for combination in subCombinations {
                let newCombination = String(character) + combination
                currentCombinations.append(newCombination)
            }
        }
        letterCombinationsTable[index] = currentCombinations
        return currentCombinations
    }
}
