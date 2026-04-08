//
//  NumberOfIslands.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 12/14/25.
//

class NumberOfIslands {
    
    struct Position: Hashable {
        let row: Int
        let col: Int
    }
    
    func numIslands(_ grid: [[Character]]) -> Int {
        var refGrid = grid
        var visitedSet = Set<Position>()
        var numIslands = 0
        for row in 0..<grid.count {
            for col in 0..<grid[0].count {
                let curPosition = Position(row: row, col: col)
                if grid[row][col] == "1" {
                    if !visitedSet.contains(curPosition) {
                        //traverse island
                        recursiveDFSIsland(&refGrid, &visitedSet, curPosition)
                        numIslands += 1
                    }
                }
            }
        }

        return numIslands
    }

    func recursiveDFSIsland(_ grid: inout [[Character]],
                            _ visitedSet: inout Set<Position>,
                            _ position: Position) {
        visitedSet.insert(position)
        if position.row - 1 >= 0 && grid[position.row - 1][position.col] == "1" {
            let northPosition = Position(row: position.row - 1, col: position.col)
            if !visitedSet.contains(northPosition) {
                recursiveDFSIsland(&grid, &visitedSet, northPosition)
            }
        }
        if position.col + 1 < grid[0].count && grid[position.row][position.col + 1] == "1" {
            let eastPosition = Position(row: position.row, col: position.col + 1)
            if !visitedSet.contains(eastPosition) {
                recursiveDFSIsland(&grid, &visitedSet, eastPosition)
            }
        }
        if position.row + 1 < grid.count && grid[position.row + 1][position.col] == "1" {
            let southPosition = Position(row: position.row + 1, col: position.col)
            if !visitedSet.contains(southPosition) {
                recursiveDFSIsland(&grid, &visitedSet, southPosition)
            }
        }
        if position.col - 1 >= 0 && grid[position.row][position.col - 1] == "1" {
            let westPosition = Position(row: position.row, col: position.col - 1)
            if !visitedSet.contains(westPosition) {
                recursiveDFSIsland(&grid, &visitedSet, westPosition)
            }
        }
    }
}
