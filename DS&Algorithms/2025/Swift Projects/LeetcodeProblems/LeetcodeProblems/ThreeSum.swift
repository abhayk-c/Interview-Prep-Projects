//
//  ThreeSum.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/19/25.
//

class BruteForceThreeSumSolver {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let threeSumIndices = recursivelyComputeThreeSum(nums, 0, 0, [], 0)
        var filterSet: Set<Array<Int>> = Set<Array<Int>>()
        for threeSumPath in threeSumIndices {
            filterSet.insert(threeSumPath.sorted(by: <))
        }
        return Array(filterSet)
    }

    func recursivelyComputeThreeSum(_ nums: [Int],
                                    _ targetValue: Int,
                                    _ currentValue: Int,
                                    _ currentIndices: [Int],
                                    _ start: Int) -> [[Int]]
    {
        if currentValue == targetValue && currentIndices.count == 3 {
            return [[nums[currentIndices[0]],
                     nums[currentIndices[1]],
                     nums[currentIndices[2]]]]
        }
        if currentIndices.count > 3 {
            return []
        }
        
        var results: [[Int]] = []
        for i in start..<nums.count {
            let current = nums[i]
            let newValue = currentValue + current
            var newIndices = currentIndices
            newIndices.append(i)
            let nextResult = recursivelyComputeThreeSum(nums, targetValue, newValue, newIndices, i+1)
            if !nextResult.isEmpty {
                for sumIndexPath in nextResult {
                    results.append(sumIndexPath)
                }
            }
        }
        return results
    }
}


class OptimizedThreeSumSolver {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let target = 4
        var pairwiseSumTable: [Int: [(indexOne: Int, indexTwo: Int)]] = [:]
        var sortedNums = nums.sorted(by: <)
        for i in 0..<sortedNums.count {
            for j in i+1..<sortedNums.count {
                let pairwiseSum = sortedNums[i] + sortedNums[j]
                if pairwiseSumTable[pairwiseSum] != nil {
                    pairwiseSumTable[pairwiseSum]?.append((indexOne: i, indexTwo: j))
                } else {
                    pairwiseSumTable[pairwiseSum] = [(indexOne: i, indexTwo: j)]
                }
            }
        }

        var threeSumIndices: [[Int]] = []
        for (pairwiseSum, indexList) in pairwiseSumTable {
            let finalTarget = target - pairwiseSum
            for pairwiseIndex in indexList {
                let finalTargetIndex = binarySearchForTarget(&sortedNums, 0, sortedNums.count-1, finalTarget, pairwiseIndex)
                if finalTargetIndex != -1 {
                    var result = [sortedNums[finalTargetIndex], sortedNums[pairwiseIndex.indexOne], sortedNums[pairwiseIndex.indexTwo]]
                    threeSumIndices.append(result)
                }
            }
        }
        
        var filterSet: Set<Array<Int>> = Set<Array<Int>>()
        for threeSumPath in threeSumIndices {
            filterSet.insert(threeSumPath.sorted(by: <))
        }
        return Array(filterSet)
    }

    private func binarySearchForTarget(_ sortedNums: inout [Int],
                                       _ start: Int,
                                       _ end: Int,
                                       _ target: Int,
                                       _ skipIndices: (indexOne: Int, indexTwo: Int)) -> Int {
        if start > end { return -1 }
        let mid = start + ((end - start) / 2)
        if sortedNums[mid] == target {
            if mid == skipIndices.indexOne || mid == skipIndices.indexTwo {
                var j = mid+1
                while j < sortedNums.count && sortedNums[j] == target {
                    if j != skipIndices.indexOne && j != skipIndices.indexTwo { return j }
                    j += 1
                }
                j = mid-1
                while j >= 0 && sortedNums[j] == target {
                    if j != skipIndices.indexOne && j != skipIndices.indexTwo { return j }
                    j -= 1
                }
            } else {
                return mid
            }
        }
        if sortedNums[mid] < target {
            return binarySearchForTarget(&sortedNums, mid+1, end, target, skipIndices)
        } else {
            return binarySearchForTarget(&sortedNums, start, mid-1, target, skipIndices)
        }
    }

}
