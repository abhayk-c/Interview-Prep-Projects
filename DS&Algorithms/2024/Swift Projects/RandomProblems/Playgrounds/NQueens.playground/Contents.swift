import UIKit
import Foundation

/**
 * Chess Board Helpers
 */
func makeChessBoard(_ n: Int) -> [[Character]]
{
    var chessBoard: [[Character]] = []
    for i in 0..<n {
        var row: [Character] = Array(repeating: ".", count: n)
        chessBoard.append(row)
    }
    return chessBoard
}

func convertChessBoardToStringArray(_ chessBoard: inout [[Character]]) -> [String]
{
    var result: [String] = []
    for row in chessBoard { result.append(String(row)) }
    return result
}
    
/*
 * N Queens Recursive BackTracking Solution
 */
func solveNQueens(_ n: Int) -> [[String]]
{
    var chessBoard = makeChessBoard(n)
    print(chessBoard)
    var solutions: [[String]] = []
    recursivelySolveNQueens(&chessBoard, &solutions, 0, n)
    return solutions
}

func recursivelySolveNQueens(_ chessBoard: inout [[Character]], 
                             _ solutions: inout [[String]],
                             _ curRow: Int,
                             _ n: Int)
{
    if curRow >= n {
        // We found a solution
        solutions.append(convertChessBoardToStringArray(&chessBoard))
        return
    }
    for curCol in 0..<n {
        if !isQueenPlacedAbove(&chessBoard, curRow, curCol, n)
            && !isQueenPlacedDiagonalLeft(&chessBoard, curRow, curCol, n)
            && !isQueenPlacedDiagonalRight(&chessBoard, curRow, curCol, n) {
            // Place our Queen and recurse to next row.
            chessBoard[curRow][curCol] = "Q"
            recursivelySolveNQueens(&chessBoard, &solutions, curRow + 1, n)
        }
        chessBoard[curRow][curCol] = "."
    }
    return
}

/**
 * N Queens Recursive Helpers
 */
func isQueenPlacedAbove(_ chessBoard: inout [[Character]], 
                        _ row: Int,
                        _ col: Int,
                        _ n: Int) -> Bool
{
    var srow = row - 1
    while srow >= 0 {
        if chessBoard[srow][col] == "Q" { return true }
        srow -= 1
    }
    return false
}

func isQueenPlacedDiagonalRight( _ chessBoard: inout [[Character]], 
                                 _ row: Int,
                                 _ col: Int,
                                 _ n: Int) -> Bool
{
    var srow = row - 1
    var scol = col + 1
    while srow >= 0 && scol < n {
        if chessBoard[srow][scol] == "Q" { return true }
        srow -= 1
        scol += 1
    }
    return false
}

func isQueenPlacedDiagonalLeft( _ chessBoard: inout [[Character]],
                                 _ row: Int,
                                 _ col: Int,
                                 _ n: Int) -> Bool
{
    var srow = row - 1
    var scol = col - 1
    while srow >= 0 && scol >= 0 {
        if chessBoard[srow][scol] == "Q" { return true }
        srow -= 1
        scol -= 1
    }
    return false
}

print(solveNQueens(5))
print(solveNQueens(5).count)
