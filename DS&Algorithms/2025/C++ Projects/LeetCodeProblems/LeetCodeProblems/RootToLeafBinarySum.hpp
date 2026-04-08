//
//  RootToLeafBinarySum.cpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 7/1/25.
//

#include "TreeNode.hpp"

void recursiveRootToLeafBinarySum(TreeNode *node, int prevValue, int& runningSum) {
    if (node == nullptr) { return; }
    int currentPathSum = ((prevValue << 1) | (node->val));
    if (node->left == nullptr && node->right == nullptr) {
        runningSum += currentPathSum;
        return;
    } else {
        recursiveRootToLeafBinarySum(node->left, currentPathSum, runningSum);
        recursiveRootToLeafBinarySum(node->right, currentPathSum, runningSum);
    }
}

int sumBinaryNumbers(TreeNode* root) {
    int runningSum = 0;
    recursiveRootToLeafBinarySum(root, 0, runningSum);
    return runningSum;
}

