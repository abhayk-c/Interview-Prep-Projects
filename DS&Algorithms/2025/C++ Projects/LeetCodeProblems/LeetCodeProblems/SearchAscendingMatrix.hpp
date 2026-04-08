//
//  SearchAscendingMatrix.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 9/12/25.
//

#include <vector>
#include <utility>

class SolutionMatrix {
public:
    int recursivelyBinarySearch(std::vector<int>& vector, int target, int startIndex, int endIndex) {
        if (startIndex > endIndex) { return -1; }
        int midIndex = (startIndex + ((endIndex - startIndex) / 2));
        if (vector[midIndex] == target) {
            return midIndex;
        } else if (vector[midIndex] > target) {
            return recursivelyBinarySearch(vector, target, startIndex, midIndex-1);
        } else {
            return recursivelyBinarySearch(vector, target, midIndex+1, endIndex);
        }
    }
    
    bool searchMatrix(std::vector<std::vector<int>>& matrix, int target) {
        for (int i = 0; i < matrix.size(); i++) {
            if (!matrix[i].empty()) {
                int targetIndex = recursivelyBinarySearch(matrix[i], target, 0, matrix[i].size()-1);
                if (targetIndex != -1) { return true; }
            }
        }
        return false;
    }
};

class OptimizedSolutionMatrixI {
public:
    int recursivelyBinarySearch(std::vector<int>& vector, int target, int startIndex, int endIndex) {
        if (startIndex > endIndex) { return -1; }
        int midIndex = (startIndex + ((endIndex - startIndex) / 2));
        if (vector[midIndex] == target) {
            return midIndex;
        } else if (vector[midIndex] > target) {
            return recursivelyBinarySearch(vector, target, startIndex, midIndex-1);
        } else {
            return recursivelyBinarySearch(vector, target, midIndex+1, endIndex);
        }
    }
    
    bool searchMatrix(std::vector<std::vector<int>>& matrix, int target) {
        int startRow = -1;
        int endRow = -1;
        for (int i = 0; i < matrix.size(); i++) {
            if (!matrix[i].empty()) {
                int endIndex = matrix[i].size() - 1;
                int lowerBound = matrix[i][0];
                int upperBound = matrix[i][endIndex];
                if (lowerBound == target || upperBound == target) {
                    return true;
                } else {
                    if (target < lowerBound) {
                        break;
                    } else if (target > lowerBound && target < upperBound) {
                        if (startRow == -1) {
                            startRow = i;
                            endRow = i;
                        } else {
                            endRow = i;
                        }
                    }
                }
            }
        }
        
        if (startRow > -1 && endRow > -1) {
            for (int i = startRow; i <= endRow; i++) {
                if (!matrix[i].empty()) {
                    int targetIndex = recursivelyBinarySearch(matrix[i], target, 0, matrix[i].size() - 1);
                    if (targetIndex != -1) { return true; }
                }
            }
        }
        
        return false;
    }
};

class OptimizedSolutionMatrixII {
public:
    int recursivelyBinarySearchRow(std::vector<int>& rowVector, int target, int startIndex, int endIndex) {
        if (startIndex > endIndex) { return -1; }
        int midIndex = (startIndex + ((endIndex - startIndex) / 2));
        if (rowVector[midIndex] == target) {
            return midIndex;
        } else if (rowVector[midIndex] > target) {
            return recursivelyBinarySearchRow(rowVector, target, startIndex, midIndex-1);
        } else {
            return recursivelyBinarySearchRow(rowVector, target, midIndex+1, endIndex);
        }
    }
    
    std::pair<int, bool> recursivelyBinarySearchColumn(std::vector<std::vector<int>>& matrix,
                                                       int target,
                                                       int columnIndex,
                                                       int startIndex,
                                                       int endIndex) {
        if (startIndex > endIndex) {
            if (startIndex > matrix.size() - 1) { return std::make_pair(endIndex, false); }
            else if (endIndex < 0) { return std::make_pair(startIndex, false); }
            else { return std::make_pair(startIndex, false); }
        }
        int midIndex = (startIndex + ((endIndex - startIndex) / 2));
        if (matrix[midIndex][columnIndex] == target) {
            return std::make_pair(midIndex, true);
        } else if (matrix[midIndex][columnIndex] > target) {
            return recursivelyBinarySearchColumn(matrix, target, columnIndex, startIndex, midIndex-1);
        } else {
            return recursivelyBinarySearchColumn(matrix, target, columnIndex, midIndex+1, endIndex);
        }
    }
    
    bool searchMatrix(std::vector<std::vector<int>>& matrix, int target) {
        // First we prune the search base and figure out which rows to search
        auto upperBound = recursivelyBinarySearchColumn(matrix, target, 0, 0, matrix.size()-1);
        if (upperBound.second == true) { return true; }
        auto lowerBound = recursivelyBinarySearchColumn(matrix, target, matrix[0].size()-1, 0, matrix.size()-1);
        if (lowerBound.second == true) { return true; }
        
        // Binary search valid rows
        for (int i = lowerBound.first; i <= upperBound.first; i++) {
            if (!matrix[i].empty() && matrix[i].size() >= 3) {
                int targetIndex = recursivelyBinarySearchRow(matrix[i], target, 1, matrix[i].size()-2);
                if (targetIndex != -1) { return true; }
            }
        }
        return false;
    }
};
