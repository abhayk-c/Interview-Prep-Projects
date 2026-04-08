//
//  WordSearch.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/22/25.
//

struct BoardPosition: Hashable {
    let row: Int
    let col: Int
}

func exist(_ board: [[Character]], _ word: String) -> Bool
{
    var searchWord = Array(word)
    for row in 0..<board.count {
        for col in 0..<board[0].count {
            if board[row][col] == searchWord[0] {
                let startPosition = BoardPosition(row: row, col: col)
                var visitedSet = Set<BoardPosition>()
                if depthFirstSearchForWord(board, searchWord, 0, startPosition, &visitedSet) { return true }
            }
        }
    }
    return false
}

func depthFirstSearchForWord(_ board: [[Character]],
                             _ word: [Character],
                             _ wordIndex: Int,
                             _ curPosition: BoardPosition,
                             _ visitedSet: inout Set<BoardPosition>) -> Bool
{
    visitedSet.insert(curPosition)
    if wordIndex >= word.count - 1 { return true }
    if curPosition.row - 1 >= 0 && board[curPosition.row - 1][curPosition.col] == word[wordIndex + 1] {
        let nextPosition = BoardPosition(row: curPosition.row - 1, col: curPosition.col)
        if !visitedSet.contains(nextPosition) {
            if depthFirstSearchForWord(board, word, wordIndex + 1, nextPosition, &visitedSet) { return true }
        }
    }
    if curPosition.col + 1 < board[0].count && board[curPosition.row][curPosition.col + 1] == word[wordIndex + 1] {
        let nextPosition = BoardPosition(row: curPosition.row, col: curPosition.col + 1)
        if !visitedSet.contains(nextPosition) {
            if depthFirstSearchForWord(board, word, wordIndex + 1, nextPosition, &visitedSet) { return true }
        }
    }
    if curPosition.row + 1 < board.count && board[curPosition.row + 1][curPosition.col] == word[wordIndex + 1] {
        let nextPosition = BoardPosition(row: curPosition.row + 1, col: curPosition.col)
        if !visitedSet.contains(nextPosition) {
            if depthFirstSearchForWord(board, word, wordIndex + 1, nextPosition, &visitedSet) { return true }
        }
    }
    if curPosition.col - 1 >= 0 && board[curPosition.row][curPosition.col - 1] == word[wordIndex + 1] {
        let nextPosition = BoardPosition(row: curPosition.row, col: curPosition.col - 1)
        if !visitedSet.contains(nextPosition) {
            if depthFirstSearchForWord(board, word, wordIndex + 1, nextPosition, &visitedSet) { return true }
        }
    }
    visitedSet.remove(curPosition)
    return false
}
