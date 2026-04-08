//
//  SudokuChecker.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 5/24/25.
//

func isValidSudoku(_ board: [[Character]]) -> Bool {
    guard !board.isEmpty else { return false }
    var subGroupValues: [UInt16] = Array(repeating: 0, count: 9)
    var rowValues: [UInt16] = Array(repeating: 0, count: 9)
    var curColValues: UInt16 = 0
    for col in 0..<9 {
        for row in 0..<9 {
            if board[row][col] != "." {
                guard let curValue = UInt16(String(board[row][col])) else { return false }
                //First check if the column is valid
                if containsNum(&curColValues, curValue) {
                    return false
                } else {
                    setNum(&curColValues, curValue)
                }
                //Now check if the row is valid
                if containsNum(&rowValues[row], curValue) {
                    return false
                } else {
                    setNum(&rowValues[row], curValue)
                }
                //Now check if the sub-group is valid
                let subGroupIndex = subGroupIndexFor(row: row, col: col)
                if containsNum(&subGroupValues[subGroupIndex], curValue) {
                    return false
                } else {
                    setNum(&subGroupValues[subGroupIndex], curValue)
                }
            }
        }
        curColValues = 0 //we are done with a column so reset
    }
    
    return true
}

func containsNum(_ bitset: inout UInt16, _ num: UInt16) -> Bool
{
    let shift = num - 1
    let mask: UInt16 = 1
    return (bitset & (mask << shift)) != 0
}

func setNum(_ bitset: inout UInt16, _ num: UInt16)
{
    let shift = num - 1
    let mask: UInt16 = 1
    bitset |= (mask << shift)
}

func subGroupIndexFor(row: Int, col: Int) -> Int
{
    if (0...2).contains(row) && (0...2).contains(col) {
        return 0
    } else if (0...2).contains(row) && (3...5).contains(col) {
        return 1
    } else if (0...2).contains(row) && (6...8).contains(col) {
        return 2
    } else if (3...5).contains(row) && (0...2).contains(col) {
        return 3
    } else if (3...5).contains(row) && (3...5).contains(col) {
        return 4
    } else if (3...5).contains(row) && (6...8).contains(col) {
        return 5
    } else if (6...8).contains(row) && (0...2).contains(col) {
        return 6
    } else if (6...8).contains(row) && (3...5).contains(col) {
        return 7
    } else {
        return 8
    }
}
