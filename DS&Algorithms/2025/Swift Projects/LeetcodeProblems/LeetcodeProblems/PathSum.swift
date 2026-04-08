//
//  PathSum.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/23/25.
//

class PathSum {
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        return recursivelyCheckForPathSum(root, 0, targetSum)
    }

    func recursivelyCheckForPathSum(_ root: TreeNode?, _ traversedSum: Int, _ targetSum: Int) -> Bool {
        guard let currentNode = root else { return false }
        let currentSum = currentNode.val + traversedSum
        if currentSum == targetSum { return true }
        let leftTraverseSum = recursivelyCheckForPathSum(currentNode.left, currentSum, targetSum)
        if leftTraverseSum == true {
            return true
        } else {
            return recursivelyCheckForPathSum(currentNode.right, currentSum, targetSum)
        }
    }
}
