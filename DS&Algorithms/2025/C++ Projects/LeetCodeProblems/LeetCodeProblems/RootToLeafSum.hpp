//
//  RootToLeafSum.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 7/1/25.
//

#include "TreeNode.hpp"

void recursiveRootToLeafSum(TreeNode *node, int prevValue, int& runningSum) {
    if (node == nullptr) { return; }
    int currentPathSum = (prevValue * 10) + node->val;
    if (node->left == nullptr && node->right == nullptr) {
        runningSum += currentPathSum;
        return;
    } else {
        recursiveRootToLeafSum(node->left, currentPathSum, runningSum);
        recursiveRootToLeafSum(node->right, currentPathSum, runningSum);
    }
}

int sumNumbers(TreeNode* root) {
    int runningSum = 0;
    recursiveRootToLeafSum(root, 0, runningSum);
    return runningSum;
}
