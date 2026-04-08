//
//  BinaryHeap.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/14/25.
//

import Foundation

/**
 * This is a Binary Heap (priority queue) implementation in Swift.
 * The data structure is implemented as a Binary Tree with parent references
 * instead of the more space efficient array based implementation. The principals
 * for the array based heap implementation and this tree based one are the same.
 *
 * To find the heap node insertion point and removal point (last node in tree)
 * in log(N) time is an interesting algorithm involving binary representation
 * of the overall heap nead count. To learn more on this algo please read here:
 * https://shorturl.at/mlxQF (Read the stack overflow second answer)
 */
public class BinaryHeap<Value: Comparable>
{
    private class BinaryHeapNode<Data: Comparable>
    {
        var data: Data
        var left: BinaryHeapNode?
        var right: BinaryHeapNode?
        var parent: BinaryHeapNode?
        
        init(data: Data, left: BinaryHeapNode? = nil, right: BinaryHeapNode? = nil, parent: BinaryHeapNode? = nil) {
            self.data = data
            self.left = left
            self.right = right
            self.parent = parent
        }
    }
    
    private struct PrintNode
    {
        var node: BinaryHeapNode<Value>?
        var isNewLevel: Bool
    }
    
    private var root: BinaryHeapNode<Value>?
    private var nodeCount: Int
    private var comparator: (Value, Value) -> Bool
    
    public init(_ comparatorBlock: @escaping (Value, Value) -> Bool) {
        self.root = nil
        self.nodeCount = 0
        self.comparator = comparatorBlock
    }
    
    public func isEmpty() -> Bool {
        return count() == 0
    }
    
    public func count() -> Int {
        return nodeCount
    }
    
    public func peek() -> Value? {
        return root?.data ?? nil
    }
    
    public func pop() -> Value? {
        let result = root?.data
        /**
         * Guard for some basic edge cases
         */
        if root == nil { return result }
        if root?.left == nil && root?.right == nil {
            root = nil
            nodeCount -= 1
            return result
        }
        /*
         * First let's get the removal node/position (last node in the tree)
         */
        let lastNodeInfo = getLastNode(nodeCount)
        if let swapNode = lastNodeInfo.node, let direction = lastNodeInfo.direction {
            /**
             * Now let's remove the last node and insert at root
             * (remove and swap)
             */
            root?.data = swapNode.data
            if direction == 0 {
                swapNode.parent?.left = nil
            } else {
                swapNode.parent?.right = nil
            }
            nodeCount -= 1
            /**
             * Now let's restore the heap by bubbling down the inserted
             * value and swapping until we restore heap property.
             */
            topDownHeapRestore(root)
        }
        return result
    }
    
    public func insert(_ element: Value) -> Void {
        if root == nil {
            root = BinaryHeapNode<Value>(data: element)
            nodeCount += 1
        } else {
            /**
             * First lets get the insertion position (last node) if we
             * increase the heap node count and insert our new value.
             */
            let newNode = BinaryHeapNode<Value>(data: element)
            guard let lastNode = getLastNode(nodeCount + 1).node else { return }
            /**
             * Insert the new node (from left to right)
             */
            if lastNode.left == nil {
                lastNode.left = newNode
                newNode.parent = lastNode
            } else {
                lastNode.right = newNode
                newNode.parent = lastNode
            }
            nodeCount += 1
            /**
             * Now we fix the binary heap if applicable from bottom up
             * Performing swaps up the tree of the inserted node until we
             * restore the heap property.
             */
            bottomUpHeapRestore(newNode)
        }
    }
    
    /**
     * Prints the tree by performing a level order traversal.
     */
    public func printTree()
    {
        let rootNode = PrintNode(node: root, isNewLevel: true)
        var queue = [rootNode]
        while !queue.isEmpty {
            let curNode = queue.removeFirst()
            if let heapNode = curNode.node {
                if heapNode.left != nil {
                    queue.append(PrintNode(node: heapNode.left, isNewLevel: curNode.isNewLevel))
                }
                if heapNode.right != nil {
                    queue.append(PrintNode(node: heapNode.right, isNewLevel: false))
                }
                if curNode.isNewLevel {
                    print("\n\(heapNode.data)", terminator: "")
                } else {
                    print("\(heapNode.data)", terminator: "")
                }
            } else {
                break
            }
        }
        print("\n")
    }
    
    private func getLastNode(_ nodeCount: Int) -> (node: BinaryHeapNode<Value>?, direction: Int?)
    {
        let count = CGFloat(nodeCount)
        var msb = Int(log2(count)) - 1 // significant bit position
        let mask = 1
        var curNode = root
        var dir: Int? = nil
        guard msb >= 0 else { return (curNode, nil) }
        while msb >= 0 {
            dir = nodeCount & (mask << msb)
            if dir! > 0 {
                if curNode?.right != nil {
                    curNode = curNode?.right
                } else {
                    break
                }
            } else {
                if curNode?.left != nil {
                    curNode = curNode?.left
                } else {
                    break
                }
            }
            msb -= 1
        }
        
        return (curNode, dir)
    }
    
    private func bottomUpHeapRestore(_ node: BinaryHeapNode<Value>?) {
        var targetNode = node
        while let curNode = targetNode, let parentNode = curNode.parent {
            //If this is true the current node is less than parent (min-heap)
            //or it would be greater than the parent (max-heap) so we swap and bubble up
            if comparator(curNode.data, parentNode.data) {
                let temp = curNode.data
                curNode.data = parentNode.data
                parentNode.data = temp
                targetNode = curNode.parent
            } else {
                break
            }
        }
    }
    
    private func topDownHeapRestore(_ node: BinaryHeapNode<Value>?) {
        var targetNode = node
        while let curNode = targetNode {
            let childMin = getMinFromChildren(curNode)
            if let childMinValue = childMin.minValue, let direction = childMin.direction {
                if comparator(childMinValue, curNode.data) {
                    if direction == 0 {
                        let temp = curNode.data
                        curNode.data = childMinValue
                        curNode.left?.data = temp
                        targetNode = curNode.left
                    } else {
                        let temp = curNode.data
                        curNode.data = childMinValue
                        curNode.right?.data = temp
                        targetNode = curNode.right
                    }
                } else {
                    break
                }
            } else {
                break
            }
        }
    }
    
    private func getMinFromChildren(_ node: BinaryHeapNode<Value>?) -> (minValue: Value?, direction: Int?)  {
        if let leftChild = node?.left {
            if let rightChild = node?.right {
                return comparator(leftChild.data, rightChild.data) ? (leftChild.data, 0) : (rightChild.data, 1)
            } else {
                return (leftChild.data, 0)
            }
        }
        return (nil, nil)
    }
}

