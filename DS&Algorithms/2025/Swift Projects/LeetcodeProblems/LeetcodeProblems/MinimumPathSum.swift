//
//  MinimumPathSum.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/15/25.
//

/**
 * Priority Queue based solution, basically a simpler version
 * of Dijkstra's. Provides roughly O(MNLog(K)) performance where K is the
 * smaller of M and N. Much faster than the bruteforce recursive solution and
 * slightly less optimal than the DP solution.
 */
class MinPathSumPriorityQueue {
    
    struct Position: Hashable {
        let row: Int
        let col: Int
    }

    struct MinPathNode: Comparable {
        let pathCost: Int
        let position: Position
        static func < (lhs: MinPathNode, rhs: MinPathNode) -> Bool {
            return lhs.pathCost < rhs.pathCost
        }
    }

    func minPathSum(_ grid: [[Int]]) -> Int {
        var visitedSet = Set<Position>()
        var priorityQueue = BinaryHeap<MinPathNode>( { (lhs, rhs) in
            return lhs.pathCost < rhs.pathCost
        })

        let startPosition = Position(row: 0, col: 0)
        let startNode = MinPathNode(pathCost: grid[0][0], position: startPosition)
        priorityQueue.insert(startNode)
        visitedSet.insert(startPosition)
        while let currentNode = priorityQueue.pop() {
            let currentPosition = currentNode.position
            let currentPathCost = currentNode.pathCost
            if currentPosition.row == grid.count - 1 && currentPosition.col == grid[0].count - 1 {
                return currentPathCost
            }
            if currentPosition.col + 1 < grid[0].count {
                //we can try to move right
                let rightPathPosition = Position(row: currentPosition.row, col: currentPosition.col + 1)
                if !visitedSet.contains(rightPathPosition) {
                    let rightPathCost = currentPathCost + grid[rightPathPosition.row][rightPathPosition.col]
                    let rightPathNode = MinPathNode(pathCost: rightPathCost, position: rightPathPosition)
                    priorityQueue.insert(rightPathNode)
                    visitedSet.insert(rightPathPosition)
                }
            }
            if currentPosition.row + 1 < grid.count {
                //we can try to move down
                let downPathPosition = Position(row: currentPosition.row + 1, col: currentPosition.col)
                if !visitedSet.contains(downPathPosition) {
                    let downPathCost = currentPathCost + grid[downPathPosition.row][downPathPosition.col]
                    let downPathNode = MinPathNode(pathCost: downPathCost, position: downPathPosition)
                    priorityQueue.insert(downPathNode)
                    visitedSet.insert(downPathPosition)
                }
            }
        }

        //This should never even hit
        return -1
    }
}


class MinPathSumDP {
    
    struct Position: Hashable {
        let row: Int
        let col: Int
    }
    
    func minPathSum(_ grid: [[Int]]) -> Int {
        var cache: [Position : Int] = [:]
        let start = Position(row: 0, col: 0)
        let minPathSum = recursivelyComputeMinPathSum(start, grid, &cache)
        return minPathSum
    }

    func recursivelyComputeMinPathSum(_ position: Position,
                                      _ grid: [[Int]],
                                      _ cache: inout [Position : Int]) -> Int
    {
        if let cachedPathSum = cache[position] {
            return cachedPathSum
        }
        if position.row == grid.count - 1 && position.col == grid[0].count - 1 {
            return grid[position.row][position.col]
        }

        var rightSum = Int.max
        var downSum = Int.max
        if position.col + 1 < grid[0].count {
            let rightPosition = Position(row: position.row, col: position.col + 1)
            rightSum = recursivelyComputeMinPathSum(rightPosition, grid, &cache)
        }
        if position.row + 1 < grid.count {
            let downPosition = Position(row: position.row + 1, col: position.col)
            downSum = recursivelyComputeMinPathSum(downPosition, grid, &cache)
        }
        
        let curCost = grid[position.row][position.col]
        let minCostPath = curCost + min(rightSum, downSum)
        cache[position] = minCostPath
        return minCostPath
    }
}
