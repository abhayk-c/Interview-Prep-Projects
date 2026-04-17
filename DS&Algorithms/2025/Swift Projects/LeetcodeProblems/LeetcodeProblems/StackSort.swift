//
//  StackSort.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 4/12/26.
//

/**
 * Cracking the Coding problem, sort a stock using only another temporary stack.
 * Can't use any other data structure. Technically can't use an array but since
 * Swift doesnt have a Stack data structure we use a dynamic array as a stack.
 */
class SortedStack {
    
    private var arrayStack: [Int] = []
    
    public func push(_ value: Int) {
        var tempStack: [Int] = []
        while let topElement = arrayStack.last, topElement < value {
            arrayStack.removeLast()
            tempStack.append(topElement)
        }
        arrayStack.append(value)
        while let poppedElement = tempStack.popLast() {
            arrayStack.append(poppedElement)
        }
    }
    
    public func peek() -> Int? {
        return arrayStack.last
    }
    
    public func pop() -> Int? {
        return arrayStack.popLast()
    }
    
    public func isEmpty() -> Bool {
        return arrayStack.isEmpty
    }
    
}

public class ArrayStack {
    
    private var data: [Int] = []
    
    public convenience init() {
        self.init([])
    }
    
    public init(_ elements: [Int]) {
        data = elements
    }
    
    public func push(_ value: Int) {
        data.append(value)
    }
    
    public func peek() -> Int? {
        return data.last
    }
    
    public func pop() -> Int? {
        return data.popLast()
    }
    
    public func isEmpty() -> Bool {
        return data.isEmpty
    }
    
}


public func sortStack(_ arrayStack: ArrayStack) -> ArrayStack {
    var sortedStack = ArrayStack()
    while let unsortedTopElement = arrayStack.peek() {
        arrayStack.pop()
        var popCount = 0
        while let sortedTopElement = sortedStack.peek(), sortedTopElement < unsortedTopElement {
            sortedStack.pop()
            arrayStack.push(sortedTopElement)
            popCount += 1
        }
        sortedStack.push(unsortedTopElement)
        for i in 0..<popCount {
            if let popped = arrayStack.pop() {
                sortedStack.push(popped)
            }
        }
    }
    return sortedStack
}
