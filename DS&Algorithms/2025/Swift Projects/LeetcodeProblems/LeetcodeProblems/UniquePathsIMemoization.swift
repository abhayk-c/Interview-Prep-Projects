//
//  UniquePathsIMemoization.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/11/25.
//

func uniquePaths(_ m: Int, _ n: Int) -> Int {
    guard m > 0 && n > 0 else { return 0 }
    var pathCache: [[Int]] = Array(repeating: Array(repeating: -1, count: n), count: m)
    return recursivelyComputeUniquePaths(m, n, 0, 0, &pathCache)
}

func recursivelyComputeUniquePaths(_ m: Int,
                                   _ n: Int,
                                   _ curRow: Int,
                                   _ curCol: Int,
                                   _ gridCache: inout [[Int]]) -> Int
{
    if gridCache[curRow][curCol] != -1 { return gridCache[curRow][curCol] }
    if curRow == m - 1 && curCol == n - 1 { return 1 }
    var uniquePaths = 0
    if curCol + 1 < n {
        uniquePaths += recursivelyComputeUniquePaths(m, n, curRow, curCol + 1, &gridCache)
    }
    if curRow + 1 < m {
        uniquePaths += recursivelyComputeUniquePaths(m, n, curRow + 1, curCol, &gridCache)
    }
    gridCache[curRow][curCol] = uniquePaths
    return uniquePaths
}
