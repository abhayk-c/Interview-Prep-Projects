//
//  SurroundedRegions.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/21/25.
//

struct GridPosition: Hashable {
    let row: Int
    let col: Int
}

func solveSurroundedRegions(_ board: inout [[Character]]) {
    guard !board.isEmpty else { return }
    var unsurroundedRegions = Set<GridPosition>()
    for row in 1..<board.count {
        for col in 1..<board[0].count {
            if board[row][col] != "X" && !unsurroundedRegions.contains(GridPosition(row: row, col: col)) {
                var localVisitedSet = Set<GridPosition>()
                let foundPath = recursivelySearchForPathToBorder(row, col, &board, &unsurroundedRegions, &localVisitedSet)
                if foundPath {
                    for position in localVisitedSet { unsurroundedRegions.insert(position) }
                } else {
                    for position in localVisitedSet {
                        board[position.row][position.col] = "X"
                    }
                }
            }
        }
    }
}

func recursivelySearchForPathToBorder(_ curRow: Int,
                                      _ curCol: Int,
                                      _ board: inout [[Character]],
                                      _ unsurroundedRegions: inout Set<GridPosition>,
                                      _ recursiveVisitedSet: inout Set<GridPosition>) -> Bool
{
    recursiveVisitedSet.insert(GridPosition(row: curRow, col: curCol))
    if curRow == 0 || curRow == board.count - 1 { return true }
    if curCol == 0 || curCol == board[0].count - 1 { return true }
    
    //East
    if curCol - 1 >= 0 {
        if board[curRow][curCol-1] != "X" {
            if unsurroundedRegions.contains(GridPosition(row: curRow, col: curCol-1)) {
                return true
            }
            if !recursiveVisitedSet.contains(GridPosition(row: curRow, col: curCol-1)) {
                let foundPath = recursivelySearchForPathToBorder(curRow, curCol-1, &board, &unsurroundedRegions, &recursiveVisitedSet)
                if foundPath { return true }
            }
        }
    }
    //North
    if curRow - 1 >= 0 {
        if board[curRow - 1][curCol] != "X" {
            if unsurroundedRegions.contains(GridPosition(row: curRow-1, col: curCol)) {
                return true
            }
            if !recursiveVisitedSet.contains(GridPosition(row: curRow-1, col: curCol)) {
                let foundPath = recursivelySearchForPathToBorder(curRow-1, curCol, &board, &unsurroundedRegions, &recursiveVisitedSet)
                if foundPath { return true }
            }
        }
    }
    //West
    if curCol + 1 < board[0].count {
        if board[curRow][curCol+1] != "X" {
            if unsurroundedRegions.contains(GridPosition(row: curRow, col: curCol+1)) {
                return true
            }
            if !recursiveVisitedSet.contains(GridPosition(row: curRow, col: curCol+1)) {
                let foundPath = recursivelySearchForPathToBorder(curRow, curCol+1, &board, &unsurroundedRegions, &recursiveVisitedSet)
                if foundPath { return true }
            }
        }
    }
    //South
    if curRow + 1 < board.count {
        if board[curRow+1][curCol] != "X" {
            if unsurroundedRegions.contains(GridPosition(row: curRow+1, col: curCol)) {
                return true
            }
            if !recursiveVisitedSet.contains(GridPosition(row: curRow+1, col: curCol)) {
                let foundPath = recursivelySearchForPathToBorder(curRow+1, curCol, &board, &unsurroundedRegions, &recursiveVisitedSet)
                if foundPath { return true }
            }
        }
    }
    
    return false
}
