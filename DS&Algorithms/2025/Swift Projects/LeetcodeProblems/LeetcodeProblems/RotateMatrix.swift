//
//  RotateMatrix.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/2/25.
//

class MatrixRotation {
    func rotate(_ matrix: inout [[Int]]) {
        let upper = matrix.count / 2
        var i = 0
        var j = 0
        var n = matrix.count
        for _ in 0..<upper {
            rotateHelper(i, j, n, &matrix)
            i += 1
            j += 1
            n -= 2
        }
    }

    func rotateHelper(_ startRow: Int, _ startCol: Int, _ n: Int, _ matrix: inout [[Int]])
    {
        let upper = (startCol + n - 1)
        let distance = n - 1
        for i in startCol..<upper {
            var currRow = startRow
            var currCol = i
            var swapValue = matrix[currRow][currCol]
            var destColumn = -1
            var destRow = -1
            for swapCase in 0..<4 {
                if swapCase == 0 {
                    destColumn = startCol + n - 1
                    destRow = currCol
                } else if swapCase == 1 {
                    destRow = startRow + n - 1
                    let sourceCol = startCol + n - 1
                    destColumn = startRow + sourceCol - currRow
                } else if swapCase == 2 {
                    destColumn = startCol
                    destRow = currCol
                } else {
                    destRow = startRow
                    destColumn = startCol + (startRow + distance - currRow)
                }
                
                let temp = matrix[destRow][destColumn]
                matrix[destRow][destColumn] = swapValue
                swapValue = temp
                currRow = destRow
                currCol = destColumn
            }
        }
    }
}
