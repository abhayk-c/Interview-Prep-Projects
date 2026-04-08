//
//  SmallestRangeCoveringLists.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 6/26/25.
//

#include <vector>
#include <queue>
#include <functional>

struct RangeValue {
    int value;
    int row;
    int col;
    RangeValue(int value, int row, int col) : value(value), row(row), col(col) {}
};

std::vector<int> smallestRange(std::vector<std::vector<int>>& nums) {
    if (nums.empty()) { return {}; }
    auto minHeap = std::priority_queue<
        RangeValue,
        std::vector<RangeValue>,
        std::function<bool(const RangeValue&, const RangeValue&)>
    >([](const RangeValue& a, const RangeValue& b){
        return a.value > b.value;
    });
    
    //Let's populate our min-heap and initialize start and end
    int max = -100001;
    for (int i = 0; i < nums.size(); i++) {
        int currentValue = nums[i][0];
        if (currentValue > max) { max = currentValue; }
        minHeap.push(RangeValue(currentValue, i, 0));
    }
    
    std::vector<int> smallestRange;
    while (!minHeap.empty()) {
        RangeValue localMin = minHeap.top();
        // First, we record our current smallest range
        if (smallestRange.empty()) {
            smallestRange.push_back(localMin.value);
            smallestRange.push_back(max);
        } else {
            if ((max - localMin.value) < (smallestRange[1] - smallestRange[0])) {
                smallestRange[0] = localMin.value;
                smallestRange[1] = max;
            }
        }
        
        // Now, lets adjust our interval and move our window
        // (update minheap, max, etc.)
        minHeap.pop();
        if (localMin.col + 1 < nums[localMin.row].size()) {
            int nextValue = nums[localMin.row][localMin.col+1];
            minHeap.push(RangeValue(nextValue, localMin.row, localMin.col+1));
            if (nextValue > max) {
                max = nextValue;
            }
        } else {
            // If we have completely exhausted a list we just break.
            break;
        }
    }
    
    return smallestRange;
}
