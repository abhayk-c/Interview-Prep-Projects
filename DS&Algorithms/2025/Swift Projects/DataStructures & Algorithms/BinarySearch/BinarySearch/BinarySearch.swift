//
//  BinarySearch.swift
//  BinarySearch
//
//  Created by Abhay Curam on 5/30/25.
//

//Leetcode function/entry point.
public func search(_ nums: [Int], _ target: Int) -> Int {
    var _nums = nums
    return iterativeBinarySearch(&_nums, target: target) ?? -1
}

public func iterativeBinarySearch<T: Comparable>(_ elements: inout [T], target: T) -> Int?
{
    guard !elements.isEmpty else { return nil }
    var startIndex = 0
    var endIndex = elements.count - 1
    while startIndex <= endIndex {
        let midIndex = startIndex + ((endIndex - startIndex) / 2)
        let current = elements[midIndex]
        if current == target {
            return midIndex
        } else if current < target {
            startIndex = midIndex + 1
        } else {
            endIndex = midIndex - 1
        }
    }
    return nil
}

public func recursiveBinarySearch<T: Comparable>(_ elements: inout [T], target: T) -> Int?
{
    guard !elements.isEmpty else { return nil }
    return recursiveBinarySearchHelper(&elements, target, 0, elements.count - 1)
}

private func recursiveBinarySearchHelper<T: Comparable>(_ elements: inout [T],
                                                        _ target: T,
                                                        _ startIndex: Int,
                                                        _ endIndex: Int) -> Int?
{
    if startIndex > endIndex { return nil }
    let midIndex = startIndex + ((endIndex - startIndex) / 2)
    let current = elements[midIndex]
    if current == target {
        //target found
        return midIndex
    }
    else if current < target {
        //move right
        return recursiveBinarySearchHelper(&elements, target, midIndex + 1, endIndex)
    } else {
        //move left
        return recursiveBinarySearchHelper(&elements, target, startIndex, midIndex - 1)
    }
}

private func binarySearchForStartAndEnd<T: Comparable>(rotatedArray: inout [T]) -> (start: Int, end: Int)?
{
    //Cut it into two halves and just search each half, that way the
    //while (startIndex <= endIndex) { } logic stays simple.
    let midIndex = (rotatedArray.count - 1) / 2
    let seed = rotatedArray[midIndex]
    if let indices = binarySearchForStartAndEndInSubArray(&rotatedArray, midIndex, rotatedArray.count - 1, seed) {
        return indices
    } else if let indices = binarySearchForStartAndEndInSubArray(&rotatedArray, 0, midIndex - 1, seed) {
        return indices
    } else {
        return nil
    }
    
}

private func binarySearchForStartAndEndInSubArray<T: Comparable>(_ rotatedArray: inout [T],
                                                                _ start: Int,
                                                                _ end: Int,
                                                                _ seedValue: T) -> (start: Int, end: Int)?
{
    var previousValue = seedValue
    var startIndex = start
    var endIndex = end
    while startIndex <= endIndex {
        let midIndex = startIndex + ((endIndex - startIndex) / 2)
        let pivotIndex = midIndex + 1 < rotatedArray.count ? midIndex + 1 : 0
        let current = rotatedArray[midIndex]
        if current > rotatedArray[pivotIndex] {
            //We found the start and end indices
            return (pivotIndex, midIndex)
        } else {
            if current > previousValue {
                //move right
                startIndex = midIndex + 1
            } else {
                //move left
                endIndex = midIndex - 1
            }
            previousValue = current
        }
    }
    return nil
}
