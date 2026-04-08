//
//  SpiralTraversal.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/8/25.
//

class SpiralMatrixTraversal {
    
    enum SpiralTraverseDirection {
        case east
        case south
        case west
        case north
    }

    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var lowerBoundaryColumn = 0
        var upperBoundaryColumn = matrix[0].count - 1
        var lowerBoundaryRow = 0
        var upperBoundaryRow = matrix.count - 1
        var traversalDirection: SpiralTraverseDirection = .east
        var row = 0
        var col = 0
        var spiralResults: [Int] = []
        while col <= upperBoundaryColumn && col >= lowerBoundaryColumn && row <= upperBoundaryRow && row >= lowerBoundaryRow {
            spiralResults.append(matrix[row][col])
            if traversalDirection == .east {
                if col == upperBoundaryColumn {
                    row += 1
                    lowerBoundaryRow = row
                    traversalDirection = .south
                } else {
                    col += 1
                }
            } else if traversalDirection == .south {
                if row == upperBoundaryRow {
                    col -= 1
                    upperBoundaryColumn = col
                    traversalDirection = .west
                } else {
                    row += 1
                }
            } else if traversalDirection == .west {
                if col == lowerBoundaryColumn {
                    row -= 1
                    upperBoundaryRow = row
                    traversalDirection = .north
                } else {
                    col -= 1
                }
            } else {
                //north
                if row == lowerBoundaryRow {
                    col += 1
                    lowerBoundaryColumn = col
                    traversalDirection = .east
                } else {
                    row -= 1
                }
            }
        }

        return spiralResults
    }
}
