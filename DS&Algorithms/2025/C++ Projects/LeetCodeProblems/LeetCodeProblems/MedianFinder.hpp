//
//  MedianFinder.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 6/20/25.
//
#include <vector>
#include <queue>
#include <cmath>

class MedianFinder {

private:
    std::priority_queue<int, std::vector<int>, std::less<int>> lhsMaxHeap;
    std::priority_queue<int, std::vector<int>, std::greater<int>> rhsMinHeap;

public:
    void addNum(int num) {
        if (rhsMinHeap.empty()) {
            lhsMaxHeap.push(num);
        } else {
            if (num <= lhsMaxHeap.top()) {
                lhsMaxHeap.push(num);
            } else {
                rhsMinHeap.push(num);
            }
        }
        //re-balance if needed
        if (lhsMaxHeap.size() == rhsMinHeap.size() + 2) {
            rhsMinHeap.push(lhsMaxHeap.top());
            lhsMaxHeap.pop();
        } else if (rhsMinHeap.size() == lhsMaxHeap.size() + 2) {
            lhsMaxHeap.push(rhsMinHeap.top());
            rhsMinHeap.pop();
        }
    }
    
    double findMedian() {
        if (lhsMaxHeap.size() == rhsMinHeap.size()) {
            return double(lhsMaxHeap.top() + rhsMinHeap.top()) / 2;
        } else {
            return (lhsMaxHeap.size() > rhsMinHeap.size()) ? lhsMaxHeap.top() : rhsMinHeap.top();
        }
    }
    
};
