//
//  SnakeGame.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/7/25.
//

class SnakeGame {

    private var gameBoard: [[Character]] = []
    private var food: [(row: Int, col: Int)] = []
    private var curLevel = 0
    private var snakePositionsWindow: [(row: Int, col: Int)] = []
    
    init(_ width: Int, _ height: Int, _ food: [[Int]]) {
        loadGameBoard(width, height)
        loadFood(food)
        loadSnakePositions()
    }
    
    func move(_ direction: String) -> Int {
        guard let snakeHeadPos = snakePositionsWindow.last else { return -1 }
        let nextPosition = nextPositionFromDirection(direction, snakeHeadPos.row, snakeHeadPos.col)
        if isPositionOnBoard(nextPosition.row, col: nextPosition.col) {
            if gameBoard[nextPosition.row][nextPosition.col] == "F" {
                gameBoard[nextPosition.row][nextPosition.col] = "S"
                snakePositionsWindow.append(nextPosition)
                curLevel += 1
                updateBoardWithFood()
                return curLevel
            } else {
                //We aren't growing so move and clear the tail position first.
                guard let tailPos = snakePositionsWindow.first else { return -1 }
                gameBoard[tailPos.row][tailPos.col] = " "
                snakePositionsWindow.remove(at: 0)
                //Now we try to move
                if gameBoard[nextPosition.row][nextPosition.col] == "S" {
                    return -1
                } else {
                    gameBoard[nextPosition.row][nextPosition.col] = "S"
                    snakePositionsWindow.append(nextPosition)
                    return curLevel
                }
            }
        }
        return -1
    }
    
    private func loadGameBoard(_ numColumns: Int, _ numRows: Int) {
        gameBoard = Array(repeating: Array(repeating: " ", count: numColumns), count: numRows)
    }
    
    private func loadFood(_ food: [[Int]]) {
        for foodRowCol in food {
            self.food.append((row: foodRowCol.first!, col: foodRowCol.last!))
        }
        updateBoardWithFood()
    }
    
    private func updateBoardWithFood() {
        if curLevel < self.food.count {
            let curFoodPos = self.food[curLevel]
            gameBoard[curFoodPos.row][curFoodPos.col] = "F"
        }
    }
    
    private func loadSnakePositions() {
        gameBoard[0][0] = "S"
        snakePositionsWindow.append((row: 0, col: 0))
    }
    
    private func nextPositionFromDirection(_ direction: String, _ row: Int, _ col: Int) -> (row: Int, col: Int) {
        if direction == "U" {
            return (row: row - 1, col: col)
        } else if direction == "L" {
            return (row: row, col: col - 1)
        } else if direction == "D" {
            return (row: row + 1, col: col)
        } else {
            return (row: row, col: col + 1)
        }
    }
    
    private func isPositionOnBoard(_ row: Int, col: Int) -> Bool {
        return (row < gameBoard.count && row >= 0 && col < gameBoard[0].count && col >= 0)
    }
}
