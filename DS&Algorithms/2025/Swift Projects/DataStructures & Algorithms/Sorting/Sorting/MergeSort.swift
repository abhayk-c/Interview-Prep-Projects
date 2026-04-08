//
//  MergeSort.swift
//  Sorting
//
//  Created by Abhay Curam on 6/10/25.
//

/**
 * A recursive "stable" merge sort implementation in Swift.
 */
public func mergeSort<T: Comparable>(_ array: [T], _ order: SortOrder) -> [T]
{
    guard !array.isEmpty else { return [] }
    var mutableArray = array
    return recursiveMergeSort(0, array.count - 1, &mutableArray, order)
}

private func recursiveMergeSort<T: Comparable>(_ start: Int,
                                               _ end: Int,
                                               _ array: inout [T],
                                               _ order: SortOrder) -> [T]
{
    if start == end {
        return Array(repeating: array[start], count: 1)
    }
    let mid = start + ((end - start) / 2)
    var leftArray = recursiveMergeSort(start, mid, &array, order)
    var rightArray = recursiveMergeSort(mid + 1, end, &array, order)
    return mergeSortedArrays(&leftArray, &rightArray, order)
}

private func mergeSortedArrays<T: Comparable>(_ leftArray: inout [T], _ rightArray: inout [T], _ order: SortOrder) -> [T]
{
    var leftIndex = 0
    var rightIndex = 0
    var resultsIndex = 0
    var results = Array(repeating: leftArray[leftIndex], count: leftArray.count + rightArray.count)
    while leftIndex < leftArray.count && rightIndex < rightArray.count {
        if order == .ascending {
            if leftArray[leftIndex] <= rightArray[rightIndex] {
                results[resultsIndex] = leftArray[leftIndex]
                leftIndex += 1
            } else {
                results[resultsIndex] = rightArray[rightIndex]
                rightIndex += 1
            }
        } else {
            if leftArray[leftIndex] >= rightArray[rightIndex] {
                results[resultsIndex] = leftArray[leftIndex]
                leftIndex += 1
            } else {
                results[resultsIndex] = rightArray[rightIndex]
                rightIndex += 1
            }
        }
        resultsIndex += 1
    }
    if leftIndex < leftArray.count {
        while leftIndex < leftArray.count {
            results[resultsIndex] = leftArray[leftIndex]
            leftIndex += 1
            resultsIndex += 1
        }
    } else if rightIndex < rightArray.count {
        while rightIndex < rightArray.count {
            results[resultsIndex] = rightArray[rightIndex]
            rightIndex += 1
            resultsIndex += 1
        }
    }
    return results
}
