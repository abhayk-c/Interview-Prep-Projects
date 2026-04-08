//
//  PowerSet.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 9/14/25.
//

#include <vector>

class PowerSetSolution {
public:
    std::vector<std::vector<int>> recursivelyComputePowerSet(std::vector<int>& nums, int startIndex)
    {
        if (startIndex >= nums.size()) {
            std::vector<int> emptyVector;
            std::vector<std::vector<int>> results;
            results.push_back(emptyVector);
            return results;
        }
        const int currentElement = nums[startIndex];
        auto recursiveResults = recursivelyComputePowerSet(nums, startIndex+1);
        std::vector<std::vector<int>> powerSetResults;
        std::vector<int> currentElementSet = {currentElement};
        powerSetResults.push_back(currentElementSet);
        for (int i = 0; i < recursiveResults.size(); i++) {
            auto subset = recursiveResults[i];
            if (!subset.empty()) {
                subset.push_back(currentElement);
                powerSetResults.push_back(subset);
            }
        }
        for (int i = 0; i < recursiveResults.size(); i++) {
            powerSetResults.push_back(recursiveResults[i]);
        }
        return powerSetResults;
    }
    
    std::vector<std::vector<int>> subsets(std::vector<int>& nums)
    {
        return recursivelyComputePowerSet(nums, 0);
    }
};
