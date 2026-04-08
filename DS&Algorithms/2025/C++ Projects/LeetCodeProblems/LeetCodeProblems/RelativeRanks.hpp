//
//  Untitled.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 6/18/25.
//
#include <vector>
#include <queue>
#include <unordered_map>
#include <string>

std::string getRankString(const int& rank)
{
    if (rank == 1) {
        return "Gold Medal";
    } else if (rank == 2) {
        return "Silver Medal";
    } else if (rank == 3) {
        return "Bronze Medal";
    } else {
        return std::to_string(rank);
    }
}

std::vector<std::string> findRelativeRanks(const std::vector<int>& score)
{
    std::vector<std::string> ranks(score.size(), "");
    std::unordered_map<int, int> scoreAthleteIndexMap;
    for (int i = 0; i < score.size(); i++) {
        scoreAthleteIndexMap[score[i]] = i;
    }
    
    // This constructs the heap from the array in O(N) since it calls heapify()
    // and priority_queue in C++ is a array-based heap.
    std::priority_queue<int, std::vector<int>, std::less<int>> priorityQueue(score.begin(), score.end());
    int rank = 1;
    while (!priorityQueue.empty()) {
        int score = priorityQueue.top();
        int index = scoreAthleteIndexMap[score];
        ranks[index] = getRankString(rank);
        priorityQueue.pop();
        rank += 1;
    }
    
    return ranks;
}
