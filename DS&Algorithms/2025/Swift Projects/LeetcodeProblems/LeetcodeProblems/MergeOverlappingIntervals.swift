//
//  MergeOverlappingIntervals.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/24/25.
//

class MergeOverlappingIntervals {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        var sortedIntervals = intervals.sorted(by: { return $0[0] < $1[0] })
        var mergedIntervals = [[Int]]()
        var start = sortedIntervals[0][0]
        var end = sortedIntervals[0][1]
        for interval in sortedIntervals {
            let localStart = interval[0]
            let localEnd = interval[1]
            if localStart <= end {
                if localEnd > end {
                    end = localEnd
                }
            } else {
                let mergedInterval: [Int] = [start, end]
                mergedIntervals.append(mergedInterval)
                start = localStart
                end = localEnd
            }
        }
        let remainingInterval: [Int] = [start, end]
        mergedIntervals.append(remainingInterval)
        return mergedIntervals
    }
}
