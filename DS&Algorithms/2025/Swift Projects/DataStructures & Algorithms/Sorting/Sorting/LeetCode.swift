//
//  LeetCode.swift
//  Sorting
//
//  Created by Abhay Curam on 6/11/25.
//

/**
 * These are just leetcode wrappers
 */
func sortArrayWithMergeSort(_ nums: [Int]) -> [Int] {
    return mergeSort(nums, .ascending)
}

/*
 * Linear time and almost faster by a factor of 5 for the
 * leetcode problem with large input. Obviously if the input is small
 * merge sort impl is going to be better.
 */
func sortArrayWithCountingSort(_ nums: [Int]) -> [Int] {
    var mutableNums = nums
    return countingSort(&mutableNums, .ascending, -50000...50000, nil)
}

/*
 * Uses radix base 256 sort for the leetcode problem. We know that the
 * range of values is -50K, 50K so we provide 50K as the offset.
 */
func sortArrayWithRadixSort(_ nums: [Int]) -> [Int] {
    var mutableNums = nums
    return base256RadixSort(&mutableNums, .ascending, 50000)
}
