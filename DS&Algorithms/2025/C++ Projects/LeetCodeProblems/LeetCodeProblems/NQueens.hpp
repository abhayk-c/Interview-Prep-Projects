//
//  NQueens.cpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 8/6/25.
//

#include <vector>
#include <string>

/**
 * There is no way to optimize this solution via DP, this backtracking approach gives
 * the lowest bound time complexity solution which is O(N!)
 *
 * That being said the solution can be optimized a bit in the way we check for
 * conflicting columns and diagonals using hash-sets to track positions.
 * Read the editorial on Leetcode. Also the memory used can be a bit more terse,
 * a bit-set/mask can be used to track queens on the board. Either way the space
 * complexity will still be O(N^2) because the problems requires us to return all
 * solutions but its worth mentioning.
 */
class NQueensSolution {
public:
    std::vector<std::vector<std::string>> solveNQueens(int n) {
        std::vector<std::vector<char>> chessBoard = buildChessBoard(n);
        std::vector<std::vector<std::string>> solutions;
        computeNQueensSolutionsWithBackTracking(chessBoard, solutions, 0, n);
        return solutions;
    }
    
    void computeNQueensSolutionsWithBackTracking(std::vector<std::vector<char>>& chessBoard,
                                                 std::vector<std::vector<std::string>>& solutions,
                                                 const int& curRow,
                                                 const int& n)
    {
        if (curRow >= n) {
            recordSolution(chessBoard, solutions, n);
            return;
        }
        for (int curCol = 0; curCol < n; curCol++) {
            if (isLeftDiagonalClear(chessBoard, curRow, curCol) &&
                isRightDiagonalClear(chessBoard, curRow, curCol, n) &&
                isColumnClear(chessBoard, curRow, curCol)) {
                chessBoard[curRow][curCol] = 'Q';
                computeNQueensSolutionsWithBackTracking(chessBoard, solutions, curRow+1, n);
                chessBoard[curRow][curCol] = '.';
            }
        }
    }
    
    bool isLeftDiagonalClear(std::vector<std::vector<char>>& chessBoard, int row, int col) {
        while (row >= 0 && col >= 0) {
            if (chessBoard[row][col] == 'Q') { return false; }
            row--;
            col--;
        }
        return true;
    }
    
    bool isRightDiagonalClear(std::vector<std::vector<char>>& chessBoard, int row, int col, int n) {
        while (row >= 0 && col < n) {
            if (chessBoard[row][col] == 'Q') { return false; }
            row--;
            col++;
        }
        return true;
    }
    
    bool isColumnClear(std::vector<std::vector<char>>& chessBoard, int row, int col) {
        while (row >= 0) {
            if (chessBoard[row][col] == 'Q') { return false; }
            row --;
        }
        return true;
    }
    
    void recordSolution(std::vector<std::vector<char>>& chessBoard, std::vector<std::vector<std::string>>& solutions, int n) {
        std::vector<std::string> curSolution;
        for (int i = 0; i < n; i++) {
            auto curRow = chessBoard[i];
            curSolution.push_back(std::string(curRow.begin(), curRow.end()));
        }
        solutions.push_back(curSolution);
    }
    
    std::vector<std::vector<char>> buildChessBoard(int n) {
        std::vector<std::vector<char>> board;
        for (int i = 0; i < n; i++) {
            std::vector<char> row;
            for (int j = 0; j < n; j++) {
                row.push_back('.');
            }
            board.push_back(row);
        }
        return board;
    }
};
