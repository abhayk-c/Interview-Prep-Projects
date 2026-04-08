//
//  MergeSort.hpp
//  MergeSort
//
//  Created by Abhay Curam on 7/13/24.
//

#include <stdio.h>
#include <vector>
#include <functional>

/**
 * This algorithm performs a generic K-Way Merge on sorted
 * arrays of integers. Generecizing this is a design problem you
 * can think through yourself.
 */
std::vector<int> kWayMerge(std::vector<std::vector<int>> &sortedVectors);

/**
 * Generic version of the in-place sort that can work
 * on any type and calls into a user-defined comparator lambda function.
 * Integer in-place sort calls this under the hood.
 */
template <typename T, typename Func>
void sort(std::vector<int>& nums, Func comparator);

/**
 * In-Place Sort
 */
void sortIntegersInPlace(std::vector<int>& nums);

/**
 * Not In-Place (returns a new copy)
 */
std::vector<int> sortIntegers(std::vector<int>& nums);

/**
 * Iterative version of MergeSort based on a Queue for an integer array.
 * Custom solution I came up with.
 * This was actually faster than my recursive implementations
 * according to leetcode, and was in ONlogN complexity!
 */
std::vector<int> sortIntegersIteratively(std::vector<int>& nums);
