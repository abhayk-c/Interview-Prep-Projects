//
//  BinaryTreeLCA.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/21/26.
//

class BinaryTreeLCA {
    
    /**
     * Time Complexity:
     * O(N). In the worst case we make two passes through the entire tree. First to find p, then to find q.
     * Next, to find the LCA we make a single O(H) pass where H is the height of tree.
     *
     * Space Complexity:
     * O(H) where H is the height/depth of tree. In the worst case H can equal N if the binary tree is completely unbalanced.
     */
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let rootNode = root, let pNode = p, let qNode = q else { return nil }
        let pathOne = findAndGetPathToNode(rootNode, pNode)
        let pathTwo = findAndGetPathToNode(rootNode, qNode)
        guard pathOne.isEmpty == false && pathTwo.isEmpty == false else { return nil }
        var lca: TreeNode? = nil
        var index = 0
        while index < pathOne.count && index < pathTwo.count {
            if pathOne[index].node.val == pathTwo[index].node.val {
                lca = pathOne[index].node
                index += 1
            } else {
                break
            }
        }
        return lca
    }

    private func findAndGetPathToNode(_ root: TreeNode, _ target: TreeNode) -> [(node: TreeNode, visitedRight: Bool)] {
        var ancestorStack: [(node: TreeNode, visitedRight: Bool)] = []
        ancestorStack.append((node: root, visitedRight: false))
        if root.val == target.val { return ancestorStack }
        while !ancestorStack.isEmpty {
            // First we move left as far as possible
            while let currentAncestor = ancestorStack.last, let leftNode = currentAncestor.node.left {
                ancestorStack.append((node: leftNode, visitedRight: false))
                if leftNode.val == target.val { return ancestorStack }
            }
            // Pruning step - now we remove all ancestors that don't have a right subtree or we already visited.
            while let currentAncestor = ancestorStack.last {
                if currentAncestor.node.right == nil || currentAncestor.visitedRight {
                    ancestorStack.removeLast()
                } else {
                    break
                }
            }
            // Move right and update visited flag.
            if let currentAncestor = ancestorStack.last, let nextNode = currentAncestor.node.right {
                ancestorStack.removeLast()
                ancestorStack.append((node: currentAncestor.node, visitedRight: true))
                ancestorStack.append((node: nextNode, visitedRight: false))
                if nextNode.val == target.val { return ancestorStack }
            }
        }

        return ancestorStack
    }
}
