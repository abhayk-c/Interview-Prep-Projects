//
//  MergeSort.cpp
//  MergeSort
//
//  Created by Abhay Curam on 7/13/24.
//

#include <queue>
#include <stack>
#include <iostream>
#include "MergeSort.hpp"

/**
 * MARK - K-Way Merge Algorithm
 */

struct MergeNode {
    int value;
    int row;
    int col;
};

bool Compare(MergeNode lhs, MergeNode rhs)
{
    return lhs.value > rhs.value;
}

std::vector<int> kWayMerge(std::vector<std::vector<int>>& sortedVectors)
{
    std::vector<int> mergedResults = {};
    std::priority_queue<MergeNode, std::vector<MergeNode>, std::function<bool(MergeNode, MergeNode)>> pq(Compare);
    if (!sortedVectors.empty()) {
        //let's first initialize our priorityQueue.
        //Rest of the algorithm just uses the priorityQueue.
        for (int i = 0; i < sortedVectors.size(); i++) {
            if (!sortedVectors[i].empty()) {
                MergeNode node = {.value = sortedVectors[i][0], .row = i, .col = 0};
                pq.push(node);
            }
        }
        //Now we use our priority queue for the rest of algorithm.
        while (!pq.empty()) {
            const MergeNode currentMinNode = pq.top();
            pq.pop();
            mergedResults.push_back(currentMinNode.value);
            if (currentMinNode.col + 1 < sortedVectors[currentMinNode.row].size()) {
                //increment the index and push a new node
                MergeNode node = {.value = sortedVectors[currentMinNode.row][currentMinNode.col + 1], .row = currentMinNode.row, .col = currentMinNode.col + 1};
                pq.push(node);
            }
        }
    }
    
    return mergedResults;
}


/**
 * MARK - Generic "sort in place" recursive merge sort algorithms.
 */
template <typename T, typename Func>
void InPlaceMerge(std::vector<T>& nums,
                  int leftStart,
                  int leftEnd,
                  int rightStart,
                  int rightEnd,
                  Func comparator)
{
    std::vector<int> mergedVector;
    int leftIndex = leftStart;
    int rightIndex = rightStart;

    while (leftIndex <= leftEnd && rightIndex <= rightEnd) {
        if (comparator(nums[leftIndex], nums[rightIndex])) {
            mergedVector.push_back(nums[leftIndex]);
            leftIndex++;
        } else {
            mergedVector.push_back(nums[rightIndex]);
            rightIndex++;
        }
    }
    if (leftIndex <= leftEnd) {
        while(leftIndex <= leftEnd) {
            mergedVector.push_back(nums[leftIndex]);
            leftIndex++;
        }
    } else if (rightIndex <= rightEnd) {
        while(rightIndex <= rightEnd) {
            mergedVector.push_back(nums[rightIndex]);
            rightIndex++;
        }
    }
    
    int j = leftStart;
    for (int i = 0; i < mergedVector.size(); i++) {
        nums[j] = mergedVector[i];
        j++;
    }
}

template <typename T, typename Func>
void recursiveInPlaceMergeSort(std::vector<T>& nums,
                               int left,
                               int right,
                               Func comparator)
{
    if (left == right) { return; }
    int pivot = (left + ((right - left) / 2));
    recursiveInPlaceMergeSort(nums, left, pivot, comparator);
    recursiveInPlaceMergeSort(nums, pivot + 1, right, comparator);
    InPlaceMerge(nums, left, pivot, pivot + 1, right, comparator);
}

template <typename T, typename Func>
void sort(std::vector<T>& nums, Func comparator)
{
    if (nums.size() == 0) { return; }
    recursiveInPlaceMergeSort(nums, 0, (int)(nums.size() - 1), comparator);
}

/**
 * MARK - Integer merge sort algorithms.
 * The in place integer sort calls the generic API
 * while the non in-place sort does not.
 */
void sortIntegersInPlace(std::vector<int>& nums)
{
    if (nums.size() == 0) { return; }
    auto comparator = [](int lhs, int rhs) -> bool {
        return (lhs < rhs);
    };
    sort(nums, comparator);
}

std::vector<int> mergeIntegers(std::vector<int>& sortedLeft, std::vector<int>& sortedRight)
{
    std::vector<int> mergedVector;
    int leftIndex = 0;
    int rightIndex = 0;
    while (leftIndex < sortedLeft.size() && rightIndex < sortedRight.size()) {
        if (sortedLeft[leftIndex] < sortedRight[rightIndex]) {
            mergedVector.push_back(sortedLeft[leftIndex]);
            leftIndex++;
        } else {
            mergedVector.push_back(sortedRight[rightIndex]);
            rightIndex++;
        }
    }
    if (leftIndex < sortedLeft.size()) {
        while(leftIndex < sortedLeft.size()) {
            mergedVector.push_back(sortedLeft[leftIndex]);
            leftIndex++;
        }
    } else if (rightIndex < sortedRight.size()) {
        while(rightIndex < sortedRight.size()) {
            mergedVector.push_back(sortedRight[rightIndex]);
            rightIndex++;
        }
    }
    
    return mergedVector;
}

std::vector<int> recursiveMergeSortIntegers(std::vector<int>& nums, int left, int right)
{
    if (left == right) { return {nums[left]}; }
    int pivot = (left + ((right - left) / 2));
    std::vector<int> sortedLeft = recursiveMergeSortIntegers(nums, left, pivot);
    std::vector<int> sortedRight = recursiveMergeSortIntegers(nums, pivot + 1, right);
    return mergeIntegers(sortedLeft, sortedRight);
}

std::vector<int> sortIntegers(std::vector<int>& nums)
{
    if (nums.size() == 0) { return {}; }
    return recursiveMergeSortIntegers(nums, 0, (int)(nums.size() - 1));
}

/**
 * MARK - Iterative implementation of the integer merge sort algorithm.
 */
std::vector<int> sortIntegersIteratively(std::vector<int>& nums)
{
    if (nums.size() == 0) { return {}; }
    //First we populate the queue with individual element arrays
    std::queue<std::vector<int>> mergeQueue;
    for (int i = 0; i < nums.size(); i++) {
        std::vector<int> vec = {nums[i]};
        mergeQueue.push(vec);
    }
    while(mergeQueue.size() > 1) {
        std::vector<int> left = mergeQueue.front();
        mergeQueue.pop();
        std::vector<int> right = mergeQueue.front();
        mergeQueue.pop();
        mergeQueue.push(mergeIntegers(left, right));
    }
    
    std::vector<int> mergedResult = mergeQueue.front();
    mergeQueue.pop();
    return mergedResult;
}
