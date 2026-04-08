//
//  BaseConversion.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 5/20/25.
//

import math_h

/*
 * Problem 6.2 from Elements of Programming
 */
func convertToBase(_ numberAsStr: String, _ sourceBase: Int, _ targetBase: Int) -> String?
{
    let digitCharacterMap: [Int : Character] = [ 0 : "0",
                                                 1 : "1",
                                                 2 : "2",
                                                 3 : "3",
                                                 4 : "4",
                                                 5 : "5",
                                                 6 : "6",
                                                 7 : "7",
                                                 8 : "8",
                                                 9 : "9",
                                                10 : "A",
                                                11 : "B",
                                                12 : "C",
                                                13 : "D",
                                                14 : "E",
                                                15 : "F" ]
    var decimal: Int = 0
    var place: Int = 0
    var convertedNum = ""
    for character in numberAsStr.reversed() {
        if !character.isNumber { continue }
        guard let digit = character.wholeNumberValue else { return nil }
        let value = digit * Int(pow(Float(sourceBase), Float(place)))
        decimal += value
        place += 1
    }
    
    var divisor = decimal
    repeat {
        guard let remainderChar = digitCharacterMap[divisor % targetBase] else { return nil }
        convertedNum.append(remainderChar)
        divisor /= targetBase
    } while divisor > 0
    if let sign = numberAsStr.first, sign == "-" {
        convertedNum.append("-")
    }
    return String(convertedNum.reversed())
}
