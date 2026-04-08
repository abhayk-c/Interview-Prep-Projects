//
//  SearchRangeInBST.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 6/27/25.
//

#include <stack>
#include "TreeNode.hpp"

/*
 * This problem was actually on LintCode (Chinese leetcode lmao).
 * Assuming a balanced tree:
 * Time Complexity: O(LogN) + O(K) where K is the size of the interval.
 * K is the worst case because every value in the interval would then be in
 * the tree as well, thats probably not realistic in practice.
 * Space Complexity is O(LogN) for stack and O(K) for the results.
 */
std::vector<int> searchRange(TreeNode *root, int k1, int k2) {
    TreeNode *cursor = root;
    stack<TreeNode*> nodeStack;
    while (cursor != NULL) {
        if (cursor->val == k1) {
            nodeStack.push(cursor);
            break;
        } else if (cursor->val > k1) {
            nodeStack.push(cursor);
            cursor = cursor->left;
        } else {
            cursor = cursor->right;
        }
    }
    std::vector<int> valuesInRange;
    while (!nodeStack.empty()) {
        cursor = nodeStack.top();
        nodeStack.pop();
        if (cursor->val > k2) { break; }
        valuesInRange.push_back(cursor->val);
        cursor = cursor->right;
        while (cursor != NULL) {
            nodeStack.push(cursor);
            cursor = cursor->left;
        }
    }
    
    return valuesInRange;
}

