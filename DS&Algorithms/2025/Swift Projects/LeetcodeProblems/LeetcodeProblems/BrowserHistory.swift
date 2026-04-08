//
//  BrowserHistory.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 4/7/26.
//

class BrowserHistoryNode {
    var url: String
    var prev: BrowserHistoryNode?
    var next: BrowserHistoryNode?
    public init(url: String, prev: BrowserHistoryNode?, next: BrowserHistoryNode?) {
        self.url = url
        self.prev = prev
        self.next = next
    }
}

class BrowserHistory {
    
    var cursor: BrowserHistoryNode?
    
    init(_ homepage: String) {
        let node = BrowserHistoryNode(url: homepage, prev: nil, next: nil)
        cursor = node
    }
    
    func visit(_ url: String) {
        let newNode = BrowserHistoryNode(url: url, prev: nil, next: nil)
        if cursor == nil {
            cursor = newNode
        } else {
            cursor?.next = newNode
            newNode.prev = cursor
            cursor = newNode
        }
    }
    
    func back(_ steps: Int) -> String {
        var stepCount = 0
        while let unwrappedCursor = cursor, unwrappedCursor.prev != nil {
            if stepCount >= steps {
                return unwrappedCursor.url
            } else {
                cursor = unwrappedCursor.prev
                stepCount += 1
            }
        }
        return cursor!.url
    }
    
    func forward(_ steps: Int) -> String {
        var stepCount = 0
        while let unwrappedCursor = cursor, unwrappedCursor.next != nil {
            if stepCount >= steps {
                return unwrappedCursor.url
            } else {
                cursor = unwrappedCursor.next
                stepCount += 1
            }
        }
        return cursor!.url
    }
    
}
