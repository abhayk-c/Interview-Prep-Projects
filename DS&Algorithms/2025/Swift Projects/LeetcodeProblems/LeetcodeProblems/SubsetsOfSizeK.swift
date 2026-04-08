//
//  SubsetsOfSizeK.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/7/25.
//

func subsetsOfSizeK(_ n: Int, _ k: Int) -> [[Int]]
{
    guard n > 0 && k <= n else { return [[Int]]() }
    var numberAsSet = [Int]()
    for i in 1..<n+1 { numberAsSet.append(i) }
    var subsets = [[Int]]()
    let currentSet = [Int]()
    recursivelyComputeKSubsets(&numberAsSet, &subsets, currentSet, k, 0)
    return subsets
}

func recursivelyComputeKSubsets(_ set: inout [Int],
                                _ subsets: inout [[Int]],
                                _ currentSet: [Int],
                                _ k: Int,
                                _ start: Int)
{
    for i in start..<set.count {
        var candidateSet = currentSet
        candidateSet.append(set[i])
        if candidateSet.count == k {
            subsets.append(candidateSet)
        } else {
            let nextStart = i + 1
            let distance = ((set.count - nextStart) + candidateSet.count)
            if distance >= k {
                recursivelyComputeKSubsets(&set, &subsets, candidateSet, k, i+1)
            } else {
                return
            }
        }
    }
}
