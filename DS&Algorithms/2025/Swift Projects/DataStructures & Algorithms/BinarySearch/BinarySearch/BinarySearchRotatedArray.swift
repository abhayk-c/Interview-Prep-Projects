//
//  BinarySearchRotatedArray.swift
//  BinarySearch
//
//  Created by Abhay Curam on 5/30/25.
//

public func binarySearchRotatedArray<T: Comparable>(_ rotatedArray: inout [T], target: T) -> Int?
{
    guard !rotatedArray.isEmpty else { return nil }
    guard let pivotIndex = binarySearchForPivotIndex(&rotatedArray) else { return nil }
    var startIndex = 0
    var endIndex = rotatedArray.count - 1
    while startIndex <= endIndex {
        let midIndex = startIndex + ((endIndex - startIndex) / 2)
        let adjustedMidIndex = adjustIndexForPivot(pivotIndex, midIndex, arraySize: rotatedArray.count)
        let current = rotatedArray[adjustedMidIndex]
        if current == target {
            return adjustedMidIndex
        } else if current < target {
            startIndex = midIndex + 1
        } else {
            endIndex = midIndex - 1
        }
    }
    return nil
}

private func adjustIndexForPivot(_ pivotIndex: Int, _ unadjustedIndex: Int, arraySize: Int) -> Int
{
    let adjustedIndex = pivotIndex + unadjustedIndex
    return (adjustedIndex < arraySize) ? adjustedIndex : (adjustedIndex - arraySize)
}

private func binarySearchForPivotIndex<T: Comparable>(_ rotatedArray: inout [T]) -> Int?
{
    guard rotatedArray.count > 1 else { return 0 }
    //Cut it into two halves and just search each half, that way the
    //while (startIndex <= endIndex) { } logic stays simple.
    let midIndex = (rotatedArray.count - 1) / 2
    let seed = rotatedArray[midIndex]
    if let pivot = binarySearchForPivotIndexInSubArray(&rotatedArray, midIndex + 1, rotatedArray.count - 1, seed) {
        return pivot
    } else if let pivot = binarySearchForPivotIndexInSubArray(&rotatedArray, 0, midIndex - 1, seed) {
        return pivot
    } else {
        return nil
    }
    
}

private func binarySearchForPivotIndexInSubArray<T: Comparable>(_ rotatedArray: inout [T],
                                                                _ start: Int,
                                                                _ end: Int,
                                                                _ seedValue: T) -> Int?
{
    var previousValue = seedValue
    var startIndex = start
    var endIndex = end
    while startIndex <= endIndex {
        let midIndex = startIndex + ((endIndex - startIndex) / 2)
        let rightPivot = (midIndex + 1 < rotatedArray.count) ? (midIndex + 1) : 0
        let leftPivot = (midIndex - 1 >= 0) ? (midIndex - 1) : (rotatedArray.count - 1)
        let current = rotatedArray[midIndex]
        if current > rotatedArray[rightPivot] {
            //We found a pivot
            return rightPivot
        } else if current < rotatedArray[leftPivot] {
            //We found a pivot. We have to check both sides.
            return midIndex
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
