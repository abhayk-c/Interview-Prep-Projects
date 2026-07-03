//
//  LinkedList.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 6/4/26.
//

public class LinkedListNode<T: Any>
{
    var data: T
    var next: LinkedListNode<T>? = nil
    var prev: LinkedListNode<T>? = nil
    
    public init(data: T) {
        self.data = data
    }
}

public class LinkedListIterator<T: Any>: IteratorProtocol
{
    private var nodeIterator: LinkedListNode<T>?
    
    public init(head: LinkedListNode<T>?)
    {
        self.nodeIterator = head
    }
        
    public func next() -> T?
    {
        if let unwrappedNodeIterator = nodeIterator {
            let result = unwrappedNodeIterator.data
            nodeIterator = unwrappedNodeIterator.next
            return result
        }
        return nil
    }
}
    
public class LinkedList<T: Any>: BidirectionalCollection
{
    private var head: LinkedListNode<T>? = nil
    private var tail: LinkedListNode<T>? = nil
    
    public init(_ elements: [T])
    {
        var currentNode = head
        for element in elements {
            let newNode = LinkedListNode<T>(data: element)
            newNode.prev = currentNode
            if let unwrappedCurrentNode = currentNode {
                unwrappedCurrentNode.next = newNode
            } else {
                head = newNode
            }
            currentNode = newNode
            count += 1
        }
        tail = currentNode
    }
    
    // Mark - Sequence Protocol
    public func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator<T>(head: self.head)
    }
    
    // Mark - Collection & Bidirectional Collection Protocols
    
    public var count: UInt = 0
    
    public var isEmpty: Bool {
        return count <= 0
    }
    
    public var startIndex: UInt {
        return 0
    }
    
    public var endIndex: UInt {
        return count
    }
    
    public var first: T? {
        return head?.data ?? nil
    }
    
    public var last: T? {
        return tail?.data ?? nil
    }
        
    public func popFirst() -> T? {
        let result = head?.data
        head = head?.next
        head?.prev = nil
        if head == nil { tail = nil }
        if count > 0 { count -= 1 }
        return result
    }
    
    public func popLast() -> T? {
        let result = tail?.data
        tail = tail?.prev
        tail?.next = nil
        if tail == nil { head = nil }
        if count > 0 { count -= 1 }
        return result
    }
        
    public func index(after i: UInt) -> UInt {
        guard i >= startIndex && i <= endIndex else {
            fatalError("Index out of bounds, please ensure you take into account the size of your list.")
        }
        return i+1
    }
    
    public func index(before i: UInt) -> UInt {
        guard i > startIndex && i <= endIndex else {
            fatalError("Index out of bounds, please ensure you take into account the size of your list.")
        }
        return i-1
    }
    
    public subscript(position: UInt) -> T {
        var currentIndex = 0
        var currentNode = head
        while let unwrappedCurrentNode = currentNode {
            if currentIndex == position {
                return unwrappedCurrentNode.data
            }
            currentNode = unwrappedCurrentNode.next
            currentIndex += 1
        }
        fatalError("You provided an index out of bounds for your list!")
    }
    
    // Mark - Custom API's
    
    public var frontNode: LinkedListNode<T>? {
        return head
    }
    
    public var lastNode: LinkedListNode<T>? {
        return tail
    }
        
    public func popFront() -> T? {
        return popFirst()
    }
    
    public func insertFront(_ element: T) {
        let newNode = LinkedListNode<T>(data: element)
        newNode.next = head
        head?.prev = newNode
        head = newNode
        if tail == nil { tail = newNode }
        count += 1
    }
    
    public func insertLast(_ element: T) {
        let newNode = LinkedListNode<T>(data: element)
        newNode.prev = tail
        tail?.next = newNode
        tail = newNode
        if head == nil { head = newNode }
        count += 1
    }
    
    public func clear() {
        head = nil
        tail = nil
        count = 0
    }
    
    public func debugDescription() -> String {
        var output = ""
        var curNode = head
        while let unwrappedNode = curNode {
            output += "\(unwrappedNode.data) "
            curNode = curNode?.next
        }
        return output
    }
    
}
