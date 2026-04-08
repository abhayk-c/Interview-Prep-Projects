//
//  ExcelSheetColumnNumbers.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/24/25.
//

import Foundation

class ExcelSheetColumnNumbers {
    func titleToNumber(_ columnTitle: String) -> Int {
        var exp = columnTitle.count - 1
        var total = 0
        let codePointA = "A" as UnicodeScalar
        for character in columnTitle.unicodeScalars {
            let value = Int(character.value) - Int(codePointA.value) + 1
            total += (value * Int(pow(Double(26), Double(exp))))
            exp -= 1
        }
        return total
    }
}
