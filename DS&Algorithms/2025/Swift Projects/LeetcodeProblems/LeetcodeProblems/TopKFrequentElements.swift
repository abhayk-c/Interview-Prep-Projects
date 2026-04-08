//
//  TopKFrequentElements.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/3/25.
//

struct NumWithFrequency: Comparable {
    let value: Int
    let frequencyCount: Int
    
    static func < (lhs: NumWithFrequency, rhs: NumWithFrequency) -> Bool {
        return lhs.frequencyCount < rhs.frequencyCount
    }
}

class TopKFrequentElements {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var frequencyMap: [Int : Int] = [:]
        for num in nums {
            var count = 0
            if let frequencyCount = frequencyMap[num] {
                count = frequencyCount
                count += 1
            }
            frequencyMap[num] = count
        }
        
        var minHeap = BinaryHeap<NumWithFrequency>({ (lhs, rhs) -> Bool in
            return lhs < rhs
        })
        for (num, frequencyCount) in frequencyMap {
            let numWithFrequency = NumWithFrequency(value: num, frequencyCount: frequencyCount)
            if minHeap.count() < k {
                minHeap.insert(numWithFrequency)
            } else {
                if let minNumFrequencyValue = minHeap.peek() {
                    if frequencyCount > minNumFrequencyValue.frequencyCount {
                        _ = minHeap.pop()
                        minHeap.insert(numWithFrequency)
                    }
                }
            }
        }
        
        var results: [Int] = []
        while let numWithFrequency = minHeap.pop() {
            results.append(numWithFrequency.value)
        }
        return results
    }
}
