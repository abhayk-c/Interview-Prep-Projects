//
//  main.cpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 5/3/25.
//

using namespace std;

#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <random>
#include <ctime>
#include <queue>
#include <map>
#include <optional>
#include "ListSum.hpp"
#include "NormalizePaths.hpp"
#include "RelativeRanks.hpp"
#include "MedianFinder.hpp"
#include "SmallestRangeCoveringArrays.hpp"
#include "SearchRangeInBST.hpp"
#include "IsBalancedBinaryTree.hpp"
#include "RootToLeafSum.hpp"
#include "RootToLeafBinarySum.hpp"
#include "BinaryTreeSerializer.hpp"
#include "SymmetricBinaryTree.hpp"
#include "NQueens.hpp"
#include "ClosestPairOfDuplicateWords.hpp"
#include "FloodFill.hpp"
#include "SearchAscendingMatrix.hpp"
#include "PowerSet.hpp"
#include "ValueRangeTree.hpp"

int main(int argc, const char * argv[]) {
    // insert code here...
    MedianFinder runningMedian = MedianFinder();
    runningMedian.addNum(6);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(10);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(2);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(6);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(5);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(0);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(6);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(3);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(1);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(0);
    cout << runningMedian.findMedian() << endl;
    runningMedian.addNum(0);
    cout << runningMedian.findMedian() << endl;
    cout << endl;
    
    vector<vector<int>> vectors = {{0}, {0}, {0}, {10}};
    vector<int> minRange = smallestRange(vectors);
    cout << "Range: [" << minRange[0] << "," << minRange[1] << "]" << endl;
    
    auto nodeFive = new TreeNode(5);
    auto nodeThree = new TreeNode(3, nullptr, nodeFive);
    auto nodeFour = new TreeNode(4);
    auto nodeTwo = new TreeNode(2, nodeFour, nodeThree);
    auto nodeTen = new TreeNode(10);
    auto nodeSeven = new TreeNode(7, nullptr, nodeTen);
    auto nodeNine = new TreeNode(9);
    auto nodeSix = new TreeNode(6, nodeSeven, nodeNine);
    auto nodeOne = new TreeNode(1, nodeTwo, nodeSix);
    
    BinaryTreeSerializer serializer = BinaryTreeSerializer();
    string serializedTree = serializer.serialize(nodeOne);
    cout << "Serialized Tree: " << serializedTree << endl;
    
    TreeNode* root = serializer.deserialize(serializedTree);
    cout << "Re-serialized Tree: " << serializer.serialize(root) << endl;
    
    auto nQueensSolver = NQueensSolution();
    auto solutions = nQueensSolver.solveNQueens(4);
    cout << "Solving N Queens" << endl;
    
    vector<string> paragraph = {"All", "work", "and", "no", "play", "makes", "for", "fun", "results"};
    auto closestWordPair = getClosestDuplicateWords(paragraph);
    if (closestWordPair.has_value()) {
        cout << closestWordPair.value().word << ", " << closestWordPair.value().indices.first << "," << closestWordPair.value().indices.second << ", " << closestWordPair.value().distance << endl;
    } else {
        cout << "No duplicates " << endl;
    }
    
    char zeroChar = '0';
    int zeroInt = zeroChar - '0';
    cout << zeroInt << endl;
    
    int threeInt = 3;
    char threeChar = '0' + threeInt;
    cout << threeChar << endl;
    
    
    cout << "ValueRangeTree Tests: " << endl;
    
    ValueRangeTree rangeTree = ValueRangeTree();
    rangeTree.insertValueForIndexRange(0, 3, "B");
    rangeTree.insertValueForIndexRange(9, 11, "C");
    rangeTree.insertValueForIndexRange(5, 8, "A");
    
    auto resultOne = rangeTree.getValuesForRange(0, 3);
    auto resultTwo = rangeTree.getValuesForRange(5, 8);
    auto resultThree = rangeTree.getValuesForRange(9, 11);
    auto resultFour = rangeTree.getValuesForRange(1, 6);
    auto resultFive = rangeTree.getValuesForRange(6, 15);
    auto resultSix = rangeTree.getValuesForRange(-6, 15);
    
    rangeTree.insertValueForIndexRange(2, 6, "D");
    auto resultSeven = rangeTree.getValuesForRange(0, 11);
    rangeTree.insertValueForIndexRange(8, 9, "E");
    auto resultEight = rangeTree.getValuesForRange(0, 11);
    rangeTree.insertValueForIndexRange(11, 15, "F");
    auto resultNine = rangeTree.getValuesForRange(0, 15);
    
    rangeTree.insertValueForIndexRange(16, 20, "Z");
    auto resultTen = rangeTree.getValuesForRange(0, 20);
    rangeTree.insertValueForIndexRange(3, 14, "haha");
    auto resultEleven = rangeTree.getValuesForRange(0, 20);
    
    
    return 0;
}
