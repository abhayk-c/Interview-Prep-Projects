import UIKit
import Foundation

class Solution {
    
    func cacheKey(_ row: Int, _ col: Int) -> String {
        return String(row) + "," + String(col)
    }

    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var cache: [String: Int] = [:]
        return recursivelyComputeNumPaths(0, 0, m, n, &cache)
    }

    func recursivelyComputeNumPaths(_ row: Int, _ col: Int, _ numRows: Int, _ numCols: Int, _ cache: inout [String: Int]) -> Int
    {
        if row >= numRows { return 0 }
        if col >= numCols { return 0 }
        if row == numRows - 1 && col == numCols - 1 { return 1 }
        
        var numPaths = 0
        if let cachedRightNumWays = cache[cacheKey(row, col+1)] {
            numPaths += cachedRightNumWays
        } else {
            numPaths += recursivelyComputeNumPaths(row, col+1, numRows, numCols, &cache)
        }
        if let cachedDownNumWays = cache[cacheKey(row+1, col)] {
            numPaths += cachedDownNumWays
        } else {
            numPaths += recursivelyComputeNumPaths(row+1, col, numRows, numCols, &cache)
        }

        cache[cacheKey(row, col)] = numPaths
        return numPaths
    }
}
