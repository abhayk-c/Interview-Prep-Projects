//
//  MyLinkedList.swift
//  List
//
//  Created by Abhay Curam on 7/10/26.
//

/**
 * This is just a wrapper to pass Leetcode.
 */
class MyLinkedList {

    var integerList = List<Int>()
    
    init() {}
    
    func get(_ index: Int) -> Int {
        guard index >= 0 else { return -1 }
        guard let cursor = integerList[UInt(index)] else { return -1 }
        return cursor.value
    }
    
    func addAtHead(_ val: Int) {
        integerList.insertFront(val)
    }
    
    func addAtTail(_ val: Int) {
        integerList.insertBack(val)
    }
    
    func addAtIndex(_ index: Int, _ val: Int) {
        if let cursor = integerList[UInt(index)] {
            integerList.insertAt(val, cursor)
        } else if index == integerList.count {
            integerList.insertBack(val)
        }
        
    }
    
    func deleteAtIndex(_ index: Int) {
        if let cursor = integerList[UInt(index)] {
            integerList.removeAt(cursor)
        }
    }
    
}

class MyStack {

    var intStack: Stack<Int>
    
    init() {
        self.intStack = Stack<Int>()
    }
    
    func push(_ x: Int) {
        intStack.push(x)
    }
    
    func pop() -> Int {
        return intStack.pop() ?? -1
    }
    
    func top() -> Int {
        return intStack.top() ?? -1
    }
    
    func empty() -> Bool {
        return intStack.empty
    }
}

class MyQueue {

    private var integerQueue: Queue<Int>
    
    init() {
        self.integerQueue = Queue<Int>()
    }
    
    func push(_ x: Int) {
        integerQueue.enqueue(x)
    }
    
    func pop() -> Int {
        return integerQueue.dequeue() ?? -1
    }
    
    func peek() -> Int {
        return integerQueue.front() ?? -1
    }
    
    func empty() -> Bool {
        return integerQueue.empty
    }
}
