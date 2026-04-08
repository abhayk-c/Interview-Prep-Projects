//
//  NumberToHexadecimal.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/29/25.
//
import Foundation

class HexadecimalConverter {
    func toHex(_ num: Int) -> String {
        guard num != 0 else { return "0" }
        let base16Characters = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
        let normalizedNum = normalizeForTwosComplement(num)
        var hexString = ""
        var dividend = normalizedNum
        while dividend > 0 {
            let quotient = dividend >> 4
            let remainder = dividend % 16
            hexString.append(base16Characters[Int(remainder)])
            dividend = quotient
        }
        return String(hexString.reversed())
    }
    
    private func normalizeForTwosComplement(_ num: Int) -> UInt32 {
        guard num < 0 else { return UInt32(num) }
        let absValue = UInt32(abs(num))
        let flippedValue = ~(absValue)
        return UInt32(flippedValue + 1)
    }
}
