//
//  LinkedListCycleDetector.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/13/25.
//


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


class LinkedListCycleDetector {
    func hasCycle(_ head: ListNode?) -> Bool {
        var runner: ListNode? = head
        if runner != nil { runner = runner?.next }
        var cursor: ListNode? = head
        while runner != nil && cursor != nil {
            guard let unwrappedRunner = runner, let unwrappedCursor = cursor else { return false }
            if unwrappedCursor === unwrappedRunner { return true }
            else {
                runner = runner?.next
                if runner != nil { runner = runner?.next }
                cursor = cursor?.next
            }
        }
        return false
    }
}
