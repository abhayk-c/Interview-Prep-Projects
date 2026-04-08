//
//  UniquePathsIIBottomUp.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/11/25.
//

func uniquePathsBottomUp(_ m: Int, _ n: Int) -> Int {
    guard m > 0 && n > 0 else { return 0 }
    var numPathsTable: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
    numPathsTable[m-1][n-1] = 1
    var originRow = m - 1
    var originCol = n - 1
    while originRow >= 0 && originCol >= 0 {
        updateNumPathsAt(row: originRow, col: originCol, &numPathsTable)
        for i in (0..<originRow).reversed() {
            updateNumPathsAt(row: i, col: originCol, &numPathsTable)
        }
        for j in (0..<originCol).reversed() {
            updateNumPathsAt(row: originRow, col: j, &numPathsTable)
        }
        originRow -= 1
        originCol -= 1
    }
    return numPathsTable[0][0]
}

func updateNumPathsAt(row: Int, col: Int, _ numPathsTable: inout [[Int]])
{
    var numWays = numPathsTable[row][col]
    if col + 1 < numPathsTable[0].count {
        numWays += numPathsTable[row][col+1]
    }
    if row + 1 < numPathsTable.count {
        numWays += numPathsTable[row+1][col]
    }
    numPathsTable[row][col] = numWays
}
