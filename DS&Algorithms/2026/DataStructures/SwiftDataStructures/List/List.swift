//
//  List.swift
//  List
//
//  Created by Abhay Curam on 7/7/26.
//

private class ListNode<T: Any>
{
    let data: T
    var next: ListNode<T>? = nil
    var prev: ListNode<T>? = nil
    
    init(_ data: T) {
        self.data = data
    }
}

public struct ListCursor<T: Any>
{
    fileprivate let listNode: ListNode<T>
    public var value: T {
        get {
            return listNode.data
        }
    }
}

public struct ListIterator<T: Any>: IteratorProtocol
{
    var listCursor: ListCursor<T>?
    
    public init(_ listCursor: ListCursor<T>?) {
        self.listCursor = listCursor
    }
    
    mutating public func next() -> ListCursor<T>? {
        if let unwrappedListCursor = listCursor {
            if let nextNode = unwrappedListCursor.listNode.next {
                listCursor = ListCursor(listNode: nextNode)
            } else {
                listCursor = nil
            }
            return unwrappedListCursor
        }
        return nil
    }
}

public class List<T: Any>: Sequence
{
    private var head: ListNode<T>? = nil
    private var tail: ListNode<T>? = nil
    
    public private(set) var count: Int = 0
    
    public var empty: Bool {
        get {
            return count == 0
        }
    }
    
    public var front: ListCursor<T>? {
        get {
            guard let unwrappedHead = head else { return nil }
            return ListCursor(listNode: unwrappedHead)
        }
    }
    
    public var back: ListCursor<T>? {
        get {
            guard let unwrappedTail = tail else { return nil }
            return ListCursor(listNode: unwrappedTail)
        }
    }
    
    public func makeIterator() -> ListIterator<T> {
        if let unwrappedHead = head {
            let listCursor = ListCursor(listNode: unwrappedHead)
            return ListIterator<T>(listCursor)
        }
        return ListIterator<T>(nil)
    }
    
    subscript(index: UInt) -> ListCursor<T>? {
        get {
            guard index < count else { return nil }
            var listIterator = makeIterator()
            var iterationIndex = 0
            while let listCursor = listIterator.next() {
                if iterationIndex == index {
                    return listCursor
                }
                iterationIndex += 1
            }
            return nil
        }
    }
    
    public func insertFront(_ element: T)
    {
        let newNode = ListNode(element)
        if let oldHead = head {
            newNode.next = oldHead
            oldHead.prev = newNode
            head = newNode
        } else {
            head = newNode
            tail = newNode
        }
        count += 1
    }
    
    public func removeFront()
    {
        guard let oldHead = head else { return }
        if let newHead = oldHead.next {
            head = newHead
            newHead.prev = nil
            oldHead.next = nil
        } else {
            head = nil
            tail = nil
        }
        count -= 1
    }
    
    public func insertBack(_ element: T)
    {
        let newNode = ListNode(element)
        if let oldTail = tail {
            oldTail.next = newNode
            newNode.prev = oldTail
            tail = newNode
        } else {
            head = newNode
            tail = newNode
        }
        count += 1
    }
    
    public func removeBack()
    {
        guard let oldTail = tail else { return }
        if let newTail = oldTail.prev {
            tail = newTail
            newTail.next = nil
            oldTail.prev = nil
        } else {
            head = nil
            tail = nil
        }
        count -= 1
    }
    
    public func clear()
    {
        while count > 0 { removeBack() }
    }
    
    /**
     * Inserts a element before the cursor position.
     * The cursor is always a valid position in the list, if your trying to insert at the very beginning
     * or end of the list please use the insertBack() and insertFront() API's.
     */
    public func insertAt(_ element: T, _ pos: ListCursor<T>) {
        let currentNode = pos.listNode
        let newNode = ListNode(element)
        if head === currentNode {
            head = newNode
        }
        if let previousNode = currentNode.prev {
            previousNode.next = newNode
            newNode.prev = previousNode
        }
        newNode.next = currentNode
        currentNode.prev = newNode
        count += 1
    }
    
    /**
     * Removes a element at the cursor position.
     * The cursor is always a valid position in the list.
     */
    public func removeAt(_ pos: ListCursor<T>) {
        let currentNode = pos.listNode
        if currentNode === head {
            head = currentNode.next
            if head == nil { tail = nil }
        } else if currentNode === tail {
            tail = currentNode.prev
            if tail == nil { head = nil }
        }
        
        if let previousNode = currentNode.prev {
            previousNode.next = currentNode.next
        }
        if let nextNode = currentNode.next {
            nextNode.prev = currentNode.prev
        }
        count -= 1
    }
    
}
