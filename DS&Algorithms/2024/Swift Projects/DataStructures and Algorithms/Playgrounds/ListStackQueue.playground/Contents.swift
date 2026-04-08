import UIKit
import Foundation

public protocol Queue
{
    associatedtype T
    
    func enqueue(_ element: T)
    func dequeue() -> T?
    var front: T? { get }
    var back: T? { get }
}

public protocol Dequeue
{
    associatedtype T
    
    func pushFront(_ element: T)
    func pushBack(_ element: T)
    func removeFront() -> T?
    func removeBack() -> T?
    var front: T? { get }
    var back: T? { get }
}
    
public class ListNode<T: Any>
{
    var data: T
    var next: ListNode<T>? = nil
    var prev: ListNode<T>? = nil
    
    public init(data: T) {
        self.data = data
    }
}

public class ListIterator<T: Any>: IteratorProtocol
{
    private var nodeIterator: ListNode<T>?
    
    public init(head: ListNode<T>?)
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
    
public class List<T: Any>: BidirectionalCollection, Stack, Queue, Dequeue
{
    private var head: ListNode<T>? = nil
    private var tail: ListNode<T>? = nil
    
    public init(_ elements: [T])
    {
        var currentNode = head
        for element in elements {
            let newNode = ListNode<T>(data: element)
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
    public func makeIterator() -> ListIterator<T> {
        return ListIterator<T>(head: self.head)
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
        return result
    }
    
    public func popLast() -> T? {
        let result = tail?.data
        tail = tail?.prev
        tail?.next = nil
        if tail == nil { head = nil }
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
    
    public var front: T? {
        return first
    }
        
    public func popFront() -> T? {
        return popFirst()
    }
    
    public func insertFront(_ element: T) {
        let newNode = ListNode<T>(data: element)
        newNode.next = head
        head?.prev = newNode
        head = newNode
        if tail == nil { tail = newNode }
    }
    
    public func insertLast(_ element: T) {
        let newNode = ListNode<T>(data: element)
        newNode.prev = tail
        tail?.next = newNode
        tail = newNode
        if head == nil { head = newNode }
    }
    
    public func clear() {
        head = nil
        tail = nil
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
    
    // Mark - Stack API

    public var top: T? {
        return self.last
    }
    
    public func push(_ element: T) {
        self.insertLast(element)
    }
    
    public func pop() {
        self.popLast()
    }
    
    // Mark - Queue API
    
    public func enqueue(_ element: T) {
        self.insertLast(element)
    }
    
    public func dequeue() -> T? {
        return self.popFront()
    }
    
    public var back: T? {
        return last
    }
    
    // Mark - Dequeue API
    
    public func pushFront(_ element: T) {
        return insertFront(element)
    }
    
    public func pushBack(_ element: T) {
        return insertLast(element)
    }
    
    public func removeFront() -> T? {
        return popFront()
    }
    
    public func removeBack() -> T? {
        return popLast()
    }
}

let stack = List<Int>([])
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)

print(stack.top ?? "")
stack.pop()
print(stack.top ?? "")
stack.pop()
print(stack.top ?? "")
stack.pop()
print(stack.top ?? "")
stack.pop()
print(stack.top ?? "")

let queue = List<String>([])
queue.enqueue("a")
queue.enqueue("b")
queue.enqueue("c")
queue.enqueue("d")

print(queue.dequeue() ?? "")
print(queue.front ?? "")
print(queue.back ?? "")
print(queue.dequeue() ?? "")
print(queue.front ?? "")
print(queue.back ?? "")
print(queue.dequeue() ?? "")
print(queue.front ?? "")
print(queue.back ?? "")
print(queue.dequeue() ?? "")
print(queue.front ?? "")
print(queue.back ?? "")
