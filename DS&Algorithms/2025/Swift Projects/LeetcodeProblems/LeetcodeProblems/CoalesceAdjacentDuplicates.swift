//
//  CoalesceAdjacentDuplicates.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 12/4/25.
//

/*
 * Runs in O(N) time complexity but uses additional O(N) space to store
 * and return the results.
 */
public func coalesceAdjacentDuplicates(_ array: [Int]) -> [Int] {
    guard !array.isEmpty else { return [] }
    var observedValue = array[0]
    var coalescedResult: [Int] = []
    for i in 0..<array.count {
        let currentValue = array[i]
        if i != 0 {
            if currentValue != observedValue {
                observedValue = currentValue
                coalescedResult.append(currentValue)
            }
        } else {
            coalescedResult.append(currentValue)
        }
    }
    return coalescedResult
}

/*
 * A variant that uses O(1) space if we want to conserve memory use but
 * could run in O(N^2) in the worst case for time complexity.
 */
public func coalesceAdjacentDuplicatesInPlace(_ array: inout [Int]) {
    guard !array.isEmpty else { return }
    var observedValue = array[0]
    var index = 0
    while index < array.count {
        let currentValue = array[index]
        if index != 0 {
            if currentValue == observedValue {
                array.remove(at: index)
                continue
            }
        }
        observedValue = currentValue
        index += 1
    }
}


