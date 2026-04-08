//
//  BinaryTreeFormatter.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/8/25.
//

import Foundation

class BinaryTreeFormattedPrinterOne {
    
    func printTree(_ root: TreeNode?) -> [[String]] {
        let treeHeight = getHeightOfBinaryTree(root)
        let base: Double = 2
        let numColumns = Int(pow(base, Double(treeHeight))) - 1
        let numRows = treeHeight
        let row: [String] = Array(repeating: "", count: numColumns)
        var printMatrix: [[String]] = Array(repeating: row, count: numRows)
        formatTreeLevelByLevel(root, &printMatrix)
        return printMatrix
    }

    func formatTreeLevelByLevel(_ root: TreeNode?, _ printMatrix: inout [[String]]) {
        guard let currentRoot = root else { return }
        if printMatrix.isEmpty || printMatrix[0].isEmpty { return }
        struct TraversalData {
            let node: TreeNode
            let parentRow: Int
            let parentCol: Int
            let isRoot: Bool
            let isLeft: Bool
        }
        var queue: [TraversalData] = [TraversalData(node: currentRoot, parentRow: 0, parentCol: 0, isRoot: true, isLeft: false)]
        let n = printMatrix[0].count
        let m = printMatrix.count
        while !queue.isEmpty {
            let data = queue.removeFirst()
            var row = -1
            var col = -1
            if data.isRoot {
                let rootCol = (n - 1) / 2
                printMatrix[0][rootCol] = String(data.node.val)
                row = 0
                col = rootCol
            } else {
                if data.isLeft {
                    row = data.parentRow + 1
                    let base: Double = 2
                    col = data.parentCol - Int(pow(base, Double(m - 1 - data.parentRow - 1)))
                    printMatrix[row][col] = String(data.node.val)
                } else {
                    row = data.parentRow + 1
                    let base: Double = 2
                    col = data.parentCol + Int(pow(base, Double(m - 1 - data.parentRow - 1)))
                    printMatrix[row][col] = String(data.node.val)
                }
            }

            if let leftChildNode = data.node.left {
                queue.append(TraversalData(node: leftChildNode, parentRow: row, parentCol: col, isRoot: false, isLeft: true))
            }
            if let rightChildNode = data.node.right {
                queue.append(TraversalData(node: rightChildNode, parentRow: row, parentCol: col, isRoot: false, isLeft: false))
            }
        }
    }

    func getHeightOfBinaryTree(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return 0 }
        let maxDepth = max(getHeightOfBinaryTree(currentNode.left), getHeightOfBinaryTree(currentNode.right))
        return maxDepth + 1
    }

}
