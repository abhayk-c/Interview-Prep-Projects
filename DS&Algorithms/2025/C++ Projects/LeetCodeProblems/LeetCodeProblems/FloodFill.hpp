//
//  FloodFill.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 8/15/25.
//

#include <vector>
#include <queue>
#include <unordered_set>

struct pair_hash {
    std::size_t operator()(const std::pair<int,int>& p) const noexcept {
        // Combine hashes of first and second
        return std::hash<int>{}(p.first) ^ (std::hash<int>{}(p.second) << 1);
    }
};

std::vector<std::vector<int>> floodFill(std::vector<std::vector<int>>& image, int sr, int sc, int color) {
    if (image.empty()) { return image; }
    if ((sr > image.size() - 1) && (sc > image[0].size() - 1)) { return image; }
    std::queue<std::pair<int, int>> queue;
    unordered_set<std::pair<int, int>, pair_hash> visitedSet;
    queue.push({sr, sc});
    visitedSet.insert({sr, sc});
    int startColor = image[sr][sc];
    while (!queue.empty()) {
        auto current = queue.front();
        queue.pop();
        int curRow = current.first;
        int curCol = current.second;
        image[curRow][curCol] = color;
        if (curRow - 1 >= 0) {
            if (!visitedSet.contains({curRow-1, curCol}) && image[curRow - 1][curCol] == startColor) {
                queue.push({curRow-1, curCol});
                visitedSet.insert({curRow-1, curCol});
            }
        }
        if (curCol + 1 < image[0].size()) {
            if (!visitedSet.contains({curRow, curCol+1}) && image[curRow][curCol + 1] == startColor) {
                queue.push({curRow, curCol+1});
                visitedSet.insert({curRow, curCol+1});
            }
        }
        if (curRow + 1 < image.size()) {
            if (!visitedSet.contains({curRow+1, curCol}) && image[curRow+1][curCol] == startColor) {
                queue.push({curRow+1, curCol});
                visitedSet.insert({curRow+1, curCol});
            }
        }
        if (curCol - 1 >=  0) {
            if (!visitedSet.contains({curRow, curCol-1}) && image[curRow][curCol-1] == startColor) {
                queue.push({curRow, curCol-1});
                visitedSet.insert({curRow, curCol-1});
            }
        }
    }
    
    return image;
}

