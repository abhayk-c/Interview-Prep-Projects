//
//  AugmentedTreeKthNode.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/22/25.
//

class AugmentedTreeNode {
    var left: AugmentedTreeNode? = nil
    var right: AugmentedTreeNode? = nil
    let data: Any
    var subTreeCount: Int = 0
    
    public init(left: AugmentedTreeNode? = nil, right: AugmentedTreeNode? = nil, data: Any, subTreeCount: Int) {
        self.left = left
        self.right = right
        self.data = data
        self.subTreeCount = subTreeCount
    }
}

func getKthInOrderNode(_ root: AugmentedTreeNode?, _ k: Int) -> AugmentedTreeNode?
{
    var traversedCount = 0
    var currentNode = root
    while currentNode != nil {
        var leftSubTreeCount = 0
        if let leftNode = currentNode?.left {
            leftSubTreeCount = leftNode.subTreeCount + 1
        }
        if traversedCount + leftSubTreeCount < k {
            traversedCount = traversedCount + leftSubTreeCount + 1 // update distance, include current node
            if traversedCount == k {
                return currentNode // we found target node
            } else {
                currentNode = currentNode?.right // move and explore right subtree
            }
        } else {
            currentNode = currentNode?.left // move and explore left subtree
        }
    }
    return nil
}


