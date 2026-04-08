//
//  RomanNumeralConverter.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/18/25.
//

class RomanNumeralConverter {
    
    struct RomanNumeral {
        let value: Int
        let symbol: String
    }
    
    func romanToInt(_ s: String) -> Int {
        let romanCharacterValuesMap: [Character : Int] = ["I" : 1, "V" : 5, "X" : 10, "L" : 50, "C" : 100, "D": 500, "M" : 1000]
        var runningSum = 0
        var currentPlace = 0
        let romanNumeralCharacters = Array(s)
        for i in (0..<romanNumeralCharacters.count).reversed() {
            let currentRomanNumeral = romanNumeralCharacters[i]
            guard let decimalValue = romanCharacterValuesMap[currentRomanNumeral] else { return 0 }
            if decimalValue < currentPlace {
                runningSum -= decimalValue
            } else {
                runningSum += decimalValue
            }
            currentPlace = decimalValue
        }
        return runningSum
    }
    
    func intToRoman(_ num: Int) -> String {
        let romanNumerals: [RomanNumeral] = [RomanNumeral(value: 1, symbol: "I"),
                                             RomanNumeral(value: 4, symbol: "IV"),
                                             RomanNumeral(value: 5, symbol: "V"),
                                             RomanNumeral(value: 9, symbol: "IX"),
                                             RomanNumeral(value: 10, symbol: "X"),
                                             RomanNumeral(value: 40, symbol: "XL"),
                                             RomanNumeral(value: 50, symbol: "L"),
                                             RomanNumeral(value: 90, symbol: "XC"),
                                             RomanNumeral(value: 100, symbol: "C"),
                                             RomanNumeral(value: 400, symbol: "CD"),
                                             RomanNumeral(value: 500, symbol: "D"),
                                             RomanNumeral(value: 900, symbol: "CM"),
                                             RomanNumeral(value: 1000, symbol: "M")]
        
        var result = ""
        var quotient = num
        while quotient > 0 {
            guard let closestRomanNumeral = getClosestRomanNumeral(romanNumerals, quotient) else { return "" }
            let currentQuotient = quotient / closestRomanNumeral.value
            for _ in 0..<currentQuotient {
                result.append(closestRomanNumeral.symbol)
            }
            let remainder = quotient % closestRomanNumeral.value
            quotient = remainder
        }
        return result
    }

    private func getClosestRomanNumeral(_ romanNumerals: [RomanNumeral], _ num: Int) -> RomanNumeral? {
        let index = binarySearchForClosestRomanNumeral(romanNumerals, 0, romanNumerals.count-1, num)
        return (index >= 0) ? romanNumerals[index] : nil
    }

    private func binarySearchForClosestRomanNumeral(_ romanNumerals: [RomanNumeral], _ start: Int, _ end: Int, _ target: Int) -> Int {
        if start > end {
            return -1
        }
        let mid = start + ((end - start) / 2)
        if romanNumerals[mid].value == target {
            return mid
        } else {
            if romanNumerals[mid].value < target {
                if mid + 1 < romanNumerals.count {
                    if romanNumerals[mid+1].value > target {
                        return mid
                    } else {
                        return binarySearchForClosestRomanNumeral(romanNumerals, mid+1, end, target)
                    }
                } else {
                    return mid
                }
            } else {
                return binarySearchForClosestRomanNumeral(romanNumerals, start, mid-1, target)
            }
        }
    }
}
