//
//  BinarySearchTreeIterator.hpp
//  BinarySearchTree
//
//  Created by Abhay Curam on 6/25/25.
//

#include "TreeNode.hpp"

/*
 * A Iterator for our BinarySearchTree. This iterator returns copies
 * of the actual keys and values instead of a raw pointer that can be manipulated.
 * so its not the most idiomatic C++ design but it's still valid.
 * It may be more accurate to call this class a Enumerator.
 */
template <typename K, typename V>
class BinarySearchTreeIterator {
public:
    BinarySearchTreeIterator(TreeNode<K, V>* root) {
        rootNode = root;
        currentNode = nullptr;
        nodeStack = std::stack<TreeNode<K, V>*>();
    }
    
    void reset() {
        while (!nodeStack.empty()) {
            nodeStack.pop();
        }
        currentNode = nullptr;
    }
    
    std::optional<std::pair<K, V>> begin() {
        reset();
        currentNode = rootNode;
        while(currentNode != nullptr) {
            nodeStack.push(currentNode);
            currentNode = currentNode->left;
        }
        if (!nodeStack.empty()) {
            return std::make_pair(nodeStack.top()->key, nodeStack.top()->value);
        } else {
            return std::nullopt;
        }
    }
    
    std::optional<std::pair<K, V>> getNext() {
        if (!nodeStack.empty()) {
            currentNode = nodeStack.top();
            nodeStack.pop();
            currentNode = currentNode->right;
            while (currentNode != nullptr) {
                nodeStack.push(currentNode);
                currentNode = currentNode->left;
            }
            if (!nodeStack.empty()) {
                return std::make_pair(nodeStack.top()->key, nodeStack.top()->value);
            } else {
                return std::nullopt;
            }
        } else {
            return std::nullopt;
        }
    }
    
    std::optional<std::pair<K, V>> current() {
        if (!nodeStack.empty()) {
            return std::make_pair(nodeStack.top()->key, nodeStack.top()->value);
        } else {
            return std::nullopt;
        }
    }
    
private:
    TreeNode<K, V>* rootNode;
    TreeNode<K, V>* currentNode;
    std::stack<TreeNode<K, V>*> nodeStack;
};

/*
 * This is the BSTIterator for the problem on LeetCode.
 * Pretty much a direct port of my BinarySearchTreeIterator solution
 * https://leetcode.com/problems/binary-search-tree-iterator/
 */

 struct BSTTreeNode {
     int val;
     BSTTreeNode *left;
     BSTTreeNode *right;
     BSTTreeNode() : val(0), left(nullptr), right(nullptr) {}
     BSTTreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
     BSTTreeNode(int x, BSTTreeNode *left, BSTTreeNode *right) : val(x), left(left), right(right) {}
 };
 

class BSTIterator {
public:
    BSTIterator(BSTTreeNode* root) {
        root = root;
        current = root;
        nodeStack = std::stack<BSTTreeNode*>();
        while(current != nullptr) {
            nodeStack.push(current);
            current = current->left;
        }
        iterationDidStart = false;
    }
    
    int next() {
        if (!nodeStack.empty()) {
            if (!iterationDidStart) {
                iterationDidStart = true;
                return nodeStack.top()->val;
            } else {
                current = nodeStack.top();
                nodeStack.pop();
                current = current->right;
                while (current != nullptr) {
                    nodeStack.push(current);
                    current = current->left;
                }
                return (!nodeStack.empty()) ? nodeStack.top()->val : -1;
            }
        } else {
            return -1;
        }
    }
    
    bool hasNext() {
        if (nodeStack.size() > 1) {
            return true;
        } else if (nodeStack.size() == 1) {
            if (!iterationDidStart) {
                return true;
            } else {
                return (nodeStack.top()->right != nullptr);
            }
        } else {
            return false;
        }
    }
    
private:
    BSTTreeNode* root;
    BSTTreeNode* current;
    bool iterationDidStart;
    std::stack<BSTTreeNode*> nodeStack;
    
};


