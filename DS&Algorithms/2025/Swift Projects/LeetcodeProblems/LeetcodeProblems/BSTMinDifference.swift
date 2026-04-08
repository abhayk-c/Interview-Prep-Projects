//
//  MinBSTDifference.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/22/25.
//

class BSTMinDifference {
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        var globalMin = Int.max
        let minMax = recursivelyComputeMinDifference(root, &globalMin)
        return globalMin
    }

    func recursivelyComputeMinDifference(_ node: TreeNode?,
                                         _ globalMinDifference: inout Int) -> (min: Int, max: Int)? {
        guard let currentNode = node else { return nil }
        let currentVal = currentNode.val
        var currentMin = currentNode.val
        var currentMax = currentNode.val
        let leftTree = recursivelyComputeMinDifference(currentNode.left, &globalMinDifference)
        let rightTree = recursivelyComputeMinDifference(currentNode.right, &globalMinDifference)
        if let leftTreeMinMax = leftTree {
            if currentVal - leftTreeMinMax.max < globalMinDifference {
                globalMinDifference = currentVal - leftTreeMinMax.max
            }
            currentMin = leftTreeMinMax.min
        }
        if let rightTreeMinMax = rightTree {
            if rightTreeMinMax.min - currentVal < globalMinDifference {
                globalMinDifference = rightTreeMinMax.min - currentVal
            }
            currentMax = rightTreeMinMax.max
        }

        return (min: currentMin, max: currentMax)
    }
}
