//
//  LowestCommonAncestor.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/18/25.
//

// Given a tree like structure, create a function that takes two nodes and returns the nearest common ancestor.

// // Depth
// // 0       A
// //        / \
// // 1     B   C
// //      / \   \
// // 2   D   E   G
// //          \
// // 3         F
         
// let commonAncestor = getCommonAncestor(of:B, and: C) // A
// let commonAncestor = getCommonAncestor(of:A, and: B) // A
// let commonAncestor = getCommonAncestor(of:D, and: F) // B
// let commonAncestor = getCommonAncestor(of:C, and: F) // A
// let commonAncestor = getCommonAncestor(of:B, and: F) // B
// let commonAncestor = getCommonAncestor(of:Y, and: Z) // nil

class StringTreeNode {
    let value: String
    let left: StringTreeNode?
    let right: StringTreeNode?
    public init(value: String, left: StringTreeNode?, right: StringTreeNode?) {
        self.value = value
        self.left = left
        self.right = right
    }
}

enum TraversalState {
    case none, traversedLeft, traversedRight
}

class AncestorNode {
    let node: StringTreeNode
    var traversalState: TraversalState
    public init(node: StringTreeNode, traversalState: TraversalState) {
        self.node = node
        self.traversalState = traversalState
    }
}

func getCommonAncestor(_ root: StringTreeNode,
                       _ nodeOne: StringTreeNode,
                       _ nodeTwo: StringTreeNode) -> StringTreeNode? {
    var ancestorStack: [AncestorNode] = []
    if let foundNodeOne = findNodeIteratively(root, nodeOne, &ancestorStack) {
        for i in (0..<ancestorStack.count).reversed() {
            let current = ancestorStack[i]
            var foundNodeTwo: StringTreeNode?
            var localTraversalStack: [AncestorNode] = []
            if current.traversalState == .none {
                foundNodeTwo = findNodeIteratively(current.node, nodeTwo, &localTraversalStack)
            } else if current.traversalState == .traversedLeft {
                foundNodeTwo = findNodeIteratively(current.node.right, nodeTwo, &localTraversalStack)
            } else {
                foundNodeTwo = findNodeIteratively(current.node.left, nodeTwo, &localTraversalStack)
            }
            if foundNodeTwo != nil {
                return current.node //LCA
            }
        }
    }
    
    return nil
}

func findNodeIteratively(_ root: StringTreeNode?,
                         _ target: StringTreeNode?,
                         _ ancestorStack: inout [AncestorNode]) -> StringTreeNode?
{
    guard let rootNode = root, let targetNode = target else { return nil }
    let rootAncestor = AncestorNode(node: rootNode, traversalState: .none)
    ancestorStack.append(rootAncestor)
    while let currentNode = ancestorStack.last {
        if currentNode.node.value == targetNode.value {
            return currentNode.node
        }
        if currentNode.traversalState == .none {
            if let leftChild = currentNode.node.left {
                //move left
                currentNode.traversalState = .traversedLeft
                let leftChildNode = AncestorNode(node: leftChild, traversalState: .none)
                ancestorStack.append(leftChildNode)
            } else if let rightChild = currentNode.node.right {
                //move right
                currentNode.traversalState = .traversedRight
                let rightChildNode = AncestorNode(node: rightChild, traversalState: .none)
                ancestorStack.append(rightChildNode)
            } else {
                //leaf node so pop
                ancestorStack.removeLast() //pop
            }
        } else if currentNode.traversalState == .traversedLeft {
            if let rightChild = currentNode.node.right {
                //move right
                currentNode.traversalState = .traversedRight
                let rightChildNode = AncestorNode(node: rightChild, traversalState: .none)
                ancestorStack.append(rightChildNode)
            } else {
                //nothing on right so pop
                ancestorStack.removeLast() //pop
            }
        } else {
            ancestorStack.removeLast() //pop
        }
    }
    
    return nil
}
