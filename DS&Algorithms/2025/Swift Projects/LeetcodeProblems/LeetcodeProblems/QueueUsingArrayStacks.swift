//
//  QueueUsingArrayStacks.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/2/26.
//

public class QueueUsingArrayStacks {
    
    var pushArrayStack: [Int] = []
    var popArrayStack: [Int] = []
    
    init() {}
        
    func push(_ x: Int) {
        flushIfNeeded(from: &popArrayStack, to: &pushArrayStack)
        pushArrayStack.append(x)
    }
    
    func pop() -> Int {
        flushIfNeeded(from: &pushArrayStack, to: &popArrayStack)
        return popArrayStack.popLast() ?? -1
    }
        
    func peek() -> Int {
        flushIfNeeded(from: &pushArrayStack, to: &popArrayStack)
        return popArrayStack.last ?? -1
    }
        
    func empty() -> Bool {
        return popArrayStack.isEmpty && pushArrayStack.isEmpty
    }
    
    private func flushIfNeeded(from sourceArrayStack: inout [Int], to targetArrayStack: inout [Int]) {
        if !sourceArrayStack.isEmpty {
            while let popElement = sourceArrayStack.popLast() {
                targetArrayStack.append(popElement)
            }
        }
    }
    
}
