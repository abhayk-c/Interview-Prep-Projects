//
//  SparseBinarySearch.swift
//  BinarySearch
//
//  Created by Abhay Curam on 6/2/25.
//

/**
 * Cracking the Coding Problem 10.5
 *
 * Time Complexity: O(logN) in a non-sparse array or reasonably full array,
 * O(N) in the worst case when array is very sparse. You cant do better than this.
 *
 * Space Complexity: O(N)
 */

// ["at", "", "", "", "ball", "", "", "car", "", "", "dad", "", ""]
public func binarySearchSparseArray(_ array: inout [String], _ target: String) -> Int?
{
    guard !array.isEmpty else { return nil }
    guard target != "" else { return nil } //Target can't be empty string, undefined.
    var start = 0
    var end = array.count - 1
    while start <= end {
        let mid = start + ((end - start) / 2)
        if array[mid] == target {
            return mid
        } else if array[mid] == "" {
            var leftMid = mid
            var rightMid = mid
            while leftMid >= 0 && rightMid < array.count && array[leftMid] == "" && array[rightMid] == "" {
                leftMid -= 1
                rightMid += 1
            }
            if leftMid < 0 { leftMid = 0 }
            if rightMid >= array.count { rightMid = array.count - 1 }
            if array[leftMid] == target { return leftMid }
            if array[rightMid] == target { return rightMid }
            let searchDir = searchDirectionAfterPruning(array[leftMid], array[rightMid])
            if searchDir == .both || searchDir == .right {
                if array[rightMid] < target {
                    start = rightMid + 1
                } else {
                    end = leftMid - 1
                }
            } else {
                if array[leftMid] < target {
                    start = rightMid + 1
                } else {
                    end = leftMid - 1
                }
            }
        } else {
            if array[mid] < target {
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
    }
    return nil
}

enum SparseSearchDirection {
    case left
    case right
    case both
}

private func searchDirectionAfterPruning(_ leftValue: String, _ rightValue: String) -> SparseSearchDirection
{
    if leftValue != "" && rightValue != "" {
        return .both
    } else if leftValue != "" {
        return .left
    } else {
        return .right
    }
}
