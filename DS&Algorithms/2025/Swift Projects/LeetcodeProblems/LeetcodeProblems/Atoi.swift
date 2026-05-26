//
//  Atoi.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 4/28/26.
//

import Foundation

/**
 * This was a huge pain in the ass surprisingly to pass the Leetcode Grader.
 * Turned out to be a medium problem due to all the edge cases and constraints imposed.
 * More coding correctness/edge case problem than algorithmic in nature.
 */
class StringToInt {
    func myAtoi(_ s: String) -> Int {
        var numberSubStr = ""
        var sign: Int = 1
        var parsingDigitsOnly = false
        for char in s {
            if char == " " {
                if !parsingDigitsOnly {
                    continue
                } else {
                    break
                }
            } else if char == "+" || char == "-" {
                if !parsingDigitsOnly {
                    sign = (char == "+") ? 1 : -1
                    parsingDigitsOnly = true
                } else {
                    break
                }
            } else if isDigit(char) {
                if !parsingDigitsOnly { parsingDigitsOnly = true }
                numberSubStr.append(char)
            } else {
                break
            }
        }
        
        stripLeadingZeroes(&numberSubStr)
        let base: Decimal = 10
        var exp: Int = numberSubStr.count - 1
        var result: Int = 0
        // Handle Integer overflow
        guard exp <= 9 else {
            return sign < 1 ? minInteger() : maxInteger()
        }
        for char in numberSubStr {
            let multiplicand = char.wholeNumberValue ?? 0
            let multiplier = Int(NSDecimalNumber(decimal: pow(base, exp)))
            result += (multiplicand * multiplier)
            if exceedsRange(result, sign) {
                result = roundNumber(result, sign)
                break
            }
            exp -= 1
        }
        return result * sign
    }
    
    func isDigit(_ c: Character) -> Bool {
        return c == "0" || c == "1" || c == "2" || c == "3" || c == "4" || c == "5" || c == "6" || c == "7" || c == "8" || c == "9"
    }
    
    func exceedsRange(_ number: Int, _ sign: Int) -> Bool {
        let result = number * sign
        if result < 0 {
            return result < minInteger()
        } else {
            return result > maxInteger()
        }
    }
    
    func roundNumber(_ number: Int, _ sign: Int) -> Int {
        let result = number * sign
        if result < 0 {
            return abs(minInteger())
        } else {
            return abs(maxInteger())
        }
    }
    
    func maxInteger() -> Int {
        let base: Decimal = 2
        let exp: Int = 31
        return (Int(NSDecimalNumber(decimal: pow(base, exp))) - 1)
    }
    
    func minInteger() -> Int {
        let base: Decimal = 2
        let exp: Int = 31
        return Int(NSDecimalNumber(decimal: pow(base, exp))) * -1
    }
    
    func stripLeadingZeroes(_ numberStr: inout String) {
        var zeroCount = 0
        for digitChar in numberStr {
            if digitChar == "0" {
                zeroCount += 1
            } else {
                break
            }
        }
        numberStr.removeFirst(zeroCount)
    }
}
