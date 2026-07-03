//
//  MovingAverage.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 6/4/26.
//

/**
 * Time Complexity: O(1) because queue operations are O(1) and our math to return the average is constant time.
 * Space Complexity: O(C) where C is capacity or window size. It could be argued that because the capacity size C is fixed
 * the space is also constant time (O(1))
 */
class MovingAverage {

    private var queue: LinkedList<Int> = LinkedList<Int>([])
    private let capacity: Int
    private var runningTotal: Int = 0
    
    init(_ size: Int) {
        self.capacity = size
    }
    
    func next(_ val: Int) -> Double {
        if queue.count >= capacity {
            let poppedValue = queue.popFirst()!
            runningTotal -= poppedValue
        }
        queue.insertLast(val)
        runningTotal += val
        let queueCount = UInt(queue.count)
        return Double(runningTotal) / Double(queueCount)
    }
}
