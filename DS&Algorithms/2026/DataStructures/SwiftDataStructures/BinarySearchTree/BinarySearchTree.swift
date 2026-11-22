//
//  BinarySearchTree.swift
//  BinarySearchTree
//
//  Created by Abhay Curam on 9/17/26.
//

import Foundation

/**
 * Because the BST does not implement any self-balancing behavior on its own the TreeNode
 * itself is set to internal access level to make it easier to build tree's in any shape and test functionality.
 * This would be set to private or fileprivate in a real-life scenario.
 */
internal class TreeNode<Key: Comparable, Value: Any>
{
    var key: Key
    var value: Value
    var left: TreeNode<Key, Value>?
    var right: TreeNode<Key, Value>?
    
    init(key: Key, value: Value, left: TreeNode<Key, Value>? = nil, right: TreeNode<Key, Value>? = nil) {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
    }
}

public struct BSTCursor<Key: Comparable, Value: Any>: CustomStringConvertible
{
    public let key: Key
    public let value: Value
    public var description: String {
        return "(key: \(key), value: \(value)) "
    }
    
    fileprivate init?(node: TreeNode<Key, Value>?)
    {
        guard let currentNode = node else { return nil }
        self.key = currentNode.key
        self.value = currentNode.value
    }
}

/**
 * A BSTIterator used to help iterate through the BST in-order.
 *
 * Time Complexity: If the tree is balanced in the worst case next() is O(logN), but the amortized time
 * complexity is O(1) because each call to next() is not O(logN).
 *
 * Space Complexity: If the tree is balanced in the worst case the space complexity is O(logN)
 */
public class BSTIterator<Key: Comparable, Value: Any>: IteratorProtocol
{
    public typealias Element = BSTCursor<Key, Value>
    private var root: TreeNode<Key, Value>?
    private var shouldInitializeIterator = false
    private var ancestorArrayStack = [TreeNode<Key, Value>]()
    
    fileprivate init(root: TreeNode<Key, Value>?)
    {
        self.root = root
        self.shouldInitializeIterator = true
    }
    
    public func next() -> BSTCursor<Key, Value>? {
        if shouldInitializeIterator {
            shouldInitializeIterator = false
            traverseLeftStartingAt(treeRoot: root)
        } else {
            if let currentNode = ancestorArrayStack.popLast() {
                if currentNode.right != nil {
                    traverseLeftStartingAt(treeRoot: currentNode.right)
                }
            }
        }
        return BSTCursor(node: ancestorArrayStack.last)
    }
    
    private func traverseLeftStartingAt(treeRoot: TreeNode<Key, Value>?)
    {
        var nodeCursor = treeRoot
        while let currentNode = nodeCursor {
            ancestorArrayStack.append(currentNode)
            nodeCursor = currentNode.left
        }
    }
}

/**
 * This is a BinarySearchTree data structure (that currently doesn't self balance).
 * It's recommended to insert value types for the Key, but there's no way to enforce that
 * because Swift does not support an "AnyValue" type. Inserting mutable/reference types
 * for the Key produces undefined behavior and may result in degraded performance
 * over time (violating BST property).
 */
public class BinarySearchTree<Key: Comparable, Value: Any>: Sequence
{
    /**
     * Please call this getter to get the max depth of the tree at any time.
     * Performs a Post-Order traversal to compute the tree depth.
     *
     * Time Complexity: O(N), we need to search the entire tree to compute the height.
     * Space Complexity: O(H) where H is height of tree. H is logN if tree is balanced, in the worst case its N.
     */
    public var depth: Int {
        return getTreeDepth()
    }
    
    /**
     * Again just set to internal for "testing", this would be private in a real life scenario.
     * Would be good to understand how to do this better in Swift though from an access control perspective.
     */
    internal var root: TreeNode<Key, Value>? = nil
    
    /**
     * Set to internal access level for easier testability just like the TreeNode class.
     */
    internal init(root: TreeNode<Key, Value>?) {
        self.root = root
    }
    
    /**
     * Provides our custom BSTIterator for in-order sequential access to the BST's
     * keys and values. "For in" loop iteration.
     */
    public func makeIterator() -> BSTIterator<Key, Value> {
        return BSTIterator(root: root)
    }
    
    /**
     * This API leverages a pre-order traversal to return a copy of the BST.
     * The copy produces a deep copy of the tree structure (inner node references and ptrs).
     * The API makes a "best effort" at deep-copying the BST keys and values provided both
     * types conform to NSCopying and provide a correct "recursive" deep copy implementation.
     *
     * Time Complexity: O(N)
     * Space Complexity: O(N) + O(H) where H is height of tree.
     * H is logN if tree is balanced, O(N) if not balanced.
     */
    public func copy() -> BinarySearchTree<Key, Value> {
        let copiedRoot = recursivelyCopyTree(root)
        return BinarySearchTree(root: copiedRoot)
    }
    
    /**
     * Inserts a key and a value into the Binary Search Tree.
     * This method respects the BST property but assumes the tree is already balanced.
     * Does not implement "re-balancing." If a key already exists this API performs an "upsert."
     *
     * Time Complexity: O(logN) assuming balanced tree. Unbalanced its O(N)
     * Space Complexity: O(1)
     */
    public func insertKeyAndValue(_ key: Key, _ value: Value) {
        var cursor = root
        if cursor == nil {
            root = TreeNode(key: key, value: value)
            return
        }
        
        while let currentNode = cursor {
            if currentNode.key == key {
                currentNode.value = value
                return
            } else if currentNode.key > key {
                if let left = currentNode.left {
                    cursor = left
                } else {
                    currentNode.left = TreeNode(key: key, value: value)
                    return
                }
            } else {
                if let right = currentNode.right {
                    cursor = right
                } else {
                    currentNode.right = TreeNode(key: key, value: value)
                    return
                }
            }
        }
    }
    
    /**
     * Removes a value and a key from the Binary Search Tree.
     * This does NOT rebalance the tree but it implements a removal algorithm that
     * respects the BST ordering property and ensures a removal will NOT violate it.
     *
     * Time Complexity: O(N) because in the worst case the target node to remove is the largest
     * value in the BST
     *
     * Space Complexity: O(1), no additional space is used except for tracking one or two extra parent nodes.
     */
    public func removeKeyAndValue(_ key: Key) {
        var movedLeft = false
        var removalTargetParent: TreeNode<Key, Value>? = nil
        var removalTarget: TreeNode<Key, Value>? = nil
        var cursor = root
        while let currentNode = cursor {
            if currentNode.key < key {
                // Moving right, track the parent
                movedLeft = false
                removalTargetParent = currentNode
                cursor = currentNode.right
            } else if currentNode.key > key {
                // Moving left, track the parent
                movedLeft = true
                removalTargetParent = currentNode
                cursor = currentNode.left
            } else {
                // Found node to remove save it.
                // We tracked the parent on the previous iteration its either valid or nil (removing root).
                removalTarget = currentNode
                break
            }
        }
        
        if let removalTargetNode = removalTarget {
            if removalTargetNode.left == nil && removalTargetNode.right == nil {
                // We are removing a leaf node
                if let removalTargetParentNode = removalTargetParent {
                    if movedLeft {
                        removalTargetParentNode.left = nil
                    } else {
                        removalTargetParentNode.right = nil
                    }
                } else {
                    // If the removalTarget has no children and no parent then we are back to an empty tree.
                    root = nil
                }
            } else if let removalTargetRightTreeRoot = removalTargetNode.right {
                // If the node to remove has a right subtree we need to replace it with its in-order successor.
                var inOrderSuccessor = removalTargetRightTreeRoot
                var inOrderSuccessorParent = removalTargetRightTreeRoot
                while let leftChild = inOrderSuccessor.left {
                    inOrderSuccessorParent = inOrderSuccessor
                    inOrderSuccessor = leftChild
                }
                if inOrderSuccessor === inOrderSuccessorParent {
                    removalTargetNode.value = inOrderSuccessor.value
                    removalTargetNode.key = inOrderSuccessor.key
                    removalTargetNode.right = inOrderSuccessor.right
                } else {
                    removalTargetNode.value = inOrderSuccessor.value
                    removalTargetNode.key = inOrderSuccessor.key
                    inOrderSuccessorParent.left = inOrderSuccessor.right
                }
            } else if let removalTargetLeftTreeRoot = removalTargetNode.left {
                // If the node to remove only has a left sub-tree we just perform a "shift" up a level
                // This effectively deletes the node.
                if let removalTargetParentNode = removalTargetParent {
                    if movedLeft {
                        removalTargetParentNode.left = removalTargetLeftTreeRoot
                    } else {
                        removalTargetParentNode.right = removalTargetLeftTreeRoot
                    }
                } else {
                    root = removalTargetLeftTreeRoot
                }
            }
        }
    }
    
    /**
     * Does a quick lookup assuming the BST ordering property to return a value
     * in the BST for a given key. If the key does not exist this method returns nil.
     *
     * Time Complexity: O(logN) assuming balanced tree. Unbalanced tree O(N)
     * Space Complexity: O(1)
     */
    public func getValueForKey(_ key: Key) -> Value? {
        var cursor = root
        while let currentNode = cursor {
            if currentNode.key == key {
                return currentNode.value
            } else if currentNode.key > key {
                cursor = currentNode.left
            } else {
                cursor = currentNode.right
            }
        }
        return nil
    }
    
    /**
     * This API leverages in-order traversal to get all BST keys and values in sorted order.
     * Please leverage this API to get all keys and values.
     *
     * Time Complexity: O(N)
     * Space Complexity: O(N) + O(H) where H is height of tree.
     * H is logN if tree is balanced, O(N) if not balanced.
     */
    public typealias BSTKeyValue = (key: Key, value: Value)
    public func getAllKeysAndValues() -> [BSTKeyValue]
    {
        var keysAndValues: [BSTKeyValue] = []
        recursivelyGetAllKeysAndValues(root, &keysAndValues)
        return keysAndValues
    }
    
    public func clear() {
        root = nil
    }
    
    /**
     * Please call this API to print the tree level-by-level.
     * This API performs a level-order traversal of the tree (BFS).
     * If your inserting custom types for Key and Value please ensure your types
     * conform to CustomStringConvertible protocol or objC description, otherwise
     * this print output format will be undefined.
     *
     * Time Complexity: O(N)
     * Space Complexity: O(2^(logN - 1)). The space complexity utilized is equal to the size of the queue.
     * The queue is equal to the number of nodes at each level and the queue is largest at the leaf node level.
     * The number of nodes at the last leaf level is 2^(logN-1) in the worst case (fully fanned out, complete, balanced tree).
     */
    public func printTree() {
        typealias TreeNodePrintEntry = (node: TreeNode<Key, Value>, parentKey: Key?, level: Int)
        let queue = Queue<TreeNodePrintEntry>()
        guard let currentRoot = root else { return }
        queue.enqueue((currentRoot, nil, 0))
        var curLevel = 0
        while let curEntry = queue.dequeue() {
            if curEntry.level > curLevel {
                curLevel = curEntry.level
                print("\n", terminator: "")
            }
            let parentStr = (curEntry.parentKey != nil) ? "\(curEntry.parentKey, default: "nil")" : "nil"
            print("(\(curEntry.node.key), \(curEntry.node.value), \(parentStr))", terminator: " ")
            if let leftNode = curEntry.node.left {
                queue.enqueue((leftNode, curEntry.node.key, curLevel + 1))
            }
            if let rightNode = curEntry.node.right {
                queue.enqueue((rightNode, curEntry.node.key, curLevel + 1))
            }
        }
        print()
    }
    
    
    // MARK: Private Helpers
    private func getTreeDepth() -> Int
    {
        return recursivelyComputeTreeDepth(root, 0)
    }
    
    private func recursivelyComputeTreeDepth(_ node: TreeNode<Key, Value>?, _ counter: Int) -> Int
    {
        guard let currentNode = node else { return counter }
        return Swift.max(recursivelyComputeTreeDepth(currentNode.left, counter + 1),
                   recursivelyComputeTreeDepth(currentNode.right, counter + 1))
    }
    
    private func recursivelyGetAllKeysAndValues(_ node: TreeNode<Key, Value>?,
                                                _ results: inout [BSTKeyValue])
    {
        guard let currentNode = node else { return }
        recursivelyGetAllKeysAndValues(currentNode.left, &results)
        results.append((key: currentNode.key, value: currentNode.value))
        recursivelyGetAllKeysAndValues(currentNode.right, &results)
    }
    
    private func recursivelyCopyTree(_ node: TreeNode<Key, Value>?) -> TreeNode<Key, Value>?
    {
        guard let currentNode = node else { return nil }
        var copiedValue = currentNode.value
        var copiedKey = currentNode.key
        if let copyableValue = currentNode.value as? NSCopying {
            if let deepCopiedValue = copyableValue.copy() as? Value {
                copiedValue = deepCopiedValue
            }
        }
        if let copyableKey = currentNode.key as? NSCopying {
            if let deepCopiedKey = copyableKey.copy() as? Key {
                copiedKey = deepCopiedKey
            }
        }
        let newNode = TreeNode(key: copiedKey, value: copiedValue)
        newNode.left = recursivelyCopyTree(currentNode.left)
        newNode.right = recursivelyCopyTree(currentNode.right)
        return newNode
    }
    
}
