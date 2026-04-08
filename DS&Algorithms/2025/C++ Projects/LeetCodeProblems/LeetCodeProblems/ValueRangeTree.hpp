//
//  ValueRangeTree.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 11/22/25.
//

using namespace std;

#include <map>
#include <vector>
#include <string>

struct ValueRange {
    int start;
    int end;
    string value;
};

/*
 * Prompt: Generic coding interview: Build a data structure that returns a range of values.
 * For example, calling set(3, 6, ‘a’) will set indices 3, 4, and 5 to the value ‘a’. Runtime
 * should NOT be linear with the number of indices being set. Calling get(0, 7) would then
 * return [null, null, null, ‘a’, ‘a’, ‘a’, null].
 *
 * This was pretty challenging, I do recommend reviewing this solution before your substack interview,
 * please see pictures taken. And also stub a interface for a BST in Swift that exposes the API's
 * you depended on for this problem.
 */
class ValueRangeTree {
    
public:
    
    /**
     * Time complexity of this solution is: logR + K + KlogR + KLogR where R is the number
     * of ranges in our BST, and K is the number of overlapping intervals. This essentially
     * reduces to O(KLogR + logR) which is much better than O(N) where N is number of indices being set.
     *
     * The idea here is the runtime becomes bound to the number of disjoint "ranges/intervals" being set
     * as opposed to raw number of indices. If the number of Ranges is less than num indices and K on average
     * is less than R, this algorithm is very efficient.
     */
    void insertValueForIndexRange(const int& start, const int& end, const string& value)
    {
        ValueRange newValueRange = {start, end, value};
        vector<ValueRange> valueRangesToInsert;
        vector<int> rangeKeysToDelete;
        valueRangesToInsert.push_back(newValueRange);
        auto it = valueRangeBST.lower_bound(start);
        if (!valueRangeBST.empty() && it != valueRangeBST.begin()) {
            it--;
            if (!doValueRangesOverlap(newValueRange, it->second)) {
                it++;
            }
        }
        while (it != valueRangeBST.end()) {
            ValueRange currentRange = it->second;
            int currentStartKey = it->first;
            if (!doValueRangesOverlap(newValueRange, currentRange)) {
                break;
            }
            rangeKeysToDelete.push_back(currentStartKey);
            if (currentRange.start < newValueRange.start) {
                ValueRange partitionedRange = {currentRange.start, newValueRange.start-1, currentRange.value};
                valueRangesToInsert.push_back(partitionedRange);
            }
            if (currentRange.end > newValueRange.end) {
                ValueRange partitionedRange = {newValueRange.end+1, currentRange.end, currentRange.value};
                valueRangesToInsert.push_back(partitionedRange);
            }
            
            it++;
        }
        
        for (int i = 0; i < rangeKeysToDelete.size(); i++) {
            valueRangeBST.erase(rangeKeysToDelete[i]);
        }
        for (int i = 0; i < valueRangesToInsert.size(); i++) {
            const int key = valueRangesToInsert[i].start;
            const ValueRange value = valueRangesToInsert[i];
            valueRangeBST[key] = value;
        }
    }
    
    vector<string> getValuesForRange(const int& start, const int& end) {
        ValueRange queryRange = {start, end, ""};
        vector<string> values((end - start + 1), "null");
        const int offset = -start;
        auto it = valueRangeBST.lower_bound(start);
        if (!valueRangeBST.empty() && it != valueRangeBST.begin()) {
            it--;
            if (!doValueRangesOverlap(queryRange, it->second)) {
                it++;
            }
        }
        while (it != valueRangeBST.end()) {
            ValueRange currentRange = it->second;
            if (!doValueRangesOverlap(queryRange, currentRange)) {
                break;
            }
            const int start = currentRange.start;
            const int end = currentRange.end;
            for (int i = start; i <= end; i++) {
                const int insertionIndex = i + offset;
                if (insertionIndex >= 0 && insertionIndex < values.size()) {
                    values[insertionIndex] = currentRange.value;
                }
            }
            it++;
        }
        
        return values;
    }
    
    
private:
    map<int, ValueRange> valueRangeBST;
    
    bool doValueRangesOverlap(const ValueRange& rangeOne, const ValueRange& rangeTwo) {
        return (rangeTwo.end >= rangeOne.start && rangeTwo.end <= rangeOne.end)
        || (rangeTwo.start <= rangeOne.end && rangeOne.end <= rangeTwo.end);
    }
};
