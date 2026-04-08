//
//  MyLinkedList.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/8/25.
//

class IntListNode {
    let value: Int
    var next: IntListNode? = nil
    var prev: IntListNode? = nil
    public init(_ value: Int) {
        self.value = value
    }
}

class MyLinkedList {
    var head: IntListNode?
    var tail: IntListNode?
    
    func get(_ index: Int) -> Int {
        var listIndex = 0
        var cursor: IntListNode? = head
        while cursor != nil {
            if listIndex == index {
                return cursor?.value ?? -1
            }
            cursor = cursor?.next
            listIndex += 1
        }

        return -1
    }
    
    func addAtHead(_ val: Int) {
        let newNode = IntListNode(val)
        if head != nil {
            newNode.next = head
            head?.prev = newNode
            head = newNode
        } else {
            head = newNode
            tail = newNode
        }
    }
    
    func addAtTail(_ val: Int) {
        let newNode = IntListNode(val)
        if tail != nil {
            newNode.prev = tail
            tail?.next = newNode
            tail = newNode
        } else {
            head = newNode
            tail = newNode
        }
    }
    
    func addAtIndex(_ index: Int, _ val: Int) {
        var listIndex = 0
        var cursor: IntListNode? = head
        while cursor != nil {
            if listIndex == index { break }
            cursor = cursor?.next
            listIndex += 1
        }
        if index == 0 && head == nil && tail == nil  {
            //empty list
            let newNode = IntListNode(val)
            head = newNode
            tail = newNode
        } else if listIndex == index && cursor == nil {
            //inserting at the end
            let newNode = IntListNode(val)
            tail?.next = newNode
            newNode.prev = tail
            tail = newNode
        } else {
            if cursor != nil {
                //inserting at front or within list
                let newNode = IntListNode(val)
                newNode.next = cursor
                newNode.prev = cursor?.prev
                cursor?.prev = newNode
                if newNode.prev != nil {
                    newNode.prev?.next = newNode
                }
                if index == 0 { head = newNode }
            }
        }

    }
    
    func deleteAtIndex(_ index: Int) {
        var listIndex = 0
        var cursor: IntListNode? = head
        while cursor != nil {
            if listIndex == index { break }
            cursor = cursor?.next
            listIndex += 1
        }
        if let cursorNode = cursor {
            if cursorNode.prev != nil {
                cursorNode.prev?.next = cursorNode.next
            }
            if cursorNode.next != nil {
                cursorNode.next?.prev = cursorNode.prev
            }
            if head === cursorNode && tail === cursorNode {
                tail = nil
                head = nil
            } else if cursorNode === head {
                head = cursorNode.next
            } else if cursorNode === tail {
                tail = cursorNode.prev
            }
        }
    }
}
