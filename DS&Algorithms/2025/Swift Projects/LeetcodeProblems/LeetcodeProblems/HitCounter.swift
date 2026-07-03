//
//  HitCounter.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 6/10/26.
//

struct TimeStampHit {
    let timeStamp: Int
    let hitCount: Int
}

/**
 * Time Complexity: O(H) for hit() and getHits() where H is the size of the hit window. For the purpose of this problem H
 * is equal to 300 (5 minutes). In the worst case the entire "queue" needs to explored for both API's. Reverse iteration is a nice
 * speed up for the getHits() impl. Because H (the window size) is a constant value. Once could argue both of these API's time complexity
 * becomes constant time because O(H) = O(300) = O(1)
 *
 * Space Complexity: Again its O(H) where H is the size of the hit window
 */
class HitCounter {

    private let hitWindow = 299
    private var boundedMonotonicListQueue: LinkedList<TimeStampHit> = LinkedList<TimeStampHit>([])
    
    init() {}
    
    func hit(_ timestamp: Int) {
        guard let recentTimeStampEntry = boundedMonotonicListQueue.last else {
            boundedMonotonicListQueue.insertLast(TimeStampHit(timeStamp: timestamp, hitCount: 1))
            return
        }
        
        if recentTimeStampEntry.timeStamp == timestamp {
            let newCount = recentTimeStampEntry.hitCount + 1
            _ = boundedMonotonicListQueue.popLast()
            boundedMonotonicListQueue.insertLast(TimeStampHit(timeStamp: timestamp, hitCount: newCount))
        } else {
            while let oldestTimestampEntry = boundedMonotonicListQueue.first {
                if timestamp - oldestTimestampEntry.timeStamp > hitWindow {
                    _ = boundedMonotonicListQueue.popFirst()
                } else {
                    break
                }
            }
            boundedMonotonicListQueue.insertLast(TimeStampHit(timeStamp: timestamp, hitCount: 1))
        }
    }
    
    func getHits(_ timestamp: Int) -> Int {
        let start = timestamp - hitWindow
        var runningHitCount = 0
        //reverse iterate
        var cursor = boundedMonotonicListQueue.lastNode
        while let recentTimeStampEntry = cursor {
            if recentTimeStampEntry.data.timeStamp >= start {
                runningHitCount += recentTimeStampEntry.data.hitCount
                cursor = cursor?.prev
            } else {
                break
            }
        }
        return runningHitCount
    }
    
}
