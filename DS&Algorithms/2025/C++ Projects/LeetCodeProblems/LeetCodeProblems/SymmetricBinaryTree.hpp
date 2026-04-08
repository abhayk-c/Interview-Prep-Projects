//
//  SymmetricBinaryTree.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 8/6/25.
//
#include "TreeNode.hpp"

class Solution {
public:
    bool isSymmetric(TreeNode* root) {
        return recursivelyCheckForSymmetry(root, root);
    }
    
    bool recursivelyCheckForSymmetry(TreeNode* lhsPtr, TreeNode *rhsPtr) {
        if (lhsPtr != nullptr && rhsPtr != nullptr) {
            if (lhsPtr->val == rhsPtr->val) {
                bool checkLeft = recursivelyCheckForSymmetry(lhsPtr->left, rhsPtr->right);
                if (!checkLeft) { return false; }
                if (lhsPtr != rhsPtr) {
                    bool checkRight = recursivelyCheckForSymmetry(lhsPtr->right, rhsPtr->left);
                    if (!checkRight) { return false; }
                }
                return true;
            }
            return false;
        } else if (lhsPtr == nullptr && rhsPtr == nullptr) {
            return true;
        }
        return false;
    }
};
