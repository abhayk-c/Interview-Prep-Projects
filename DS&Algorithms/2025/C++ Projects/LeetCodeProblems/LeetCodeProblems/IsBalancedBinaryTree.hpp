//
//  IsBalancedBinaryTree.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 7/1/25.
//

#include "TreeNode.hpp"

int recursivelyCheckBalance(TreeNode* root)
{
    if (root == nullptr) { return 0; }
    int leftHeight = recursivelyCheckBalance(root->left);
    if (leftHeight == -1) { return -1; }
    int rightHeight = recursivelyCheckBalance(root->right);
    if (rightHeight == -1) { return -1; }
    
    if (abs(leftHeight - rightHeight) > 1) {
        return -1;
    } else {
        return 1 + max(leftHeight, rightHeight);
    }
}

bool isBalancedBinaryTree(TreeNode* root)
{
    int height = recursivelyCheckBalance(root);
    return (height == -1) ? false : true;
}
