//
//  BinarySearchTree.hpp
//  BinarySearchTree
//
//  Created by Abhay Curam on 6/24/25.
//

#include <vector>
#include <functional>
#include <optional>
#include <unordered_map>
#include <stack>
#include "TreeNode.hpp"

/**
 * This is a Binary Search Tree. It currently performs no "self balancing."
 * but it correctly reinforces the bst ordering property while inserting/removing elements,
 * manages node creating and heap memory, provides enumeration/printing API's, and abstracts
 * away a number of tree traversals that are useful when dealing with BST's.
 *
 * Self Balancing implementation/operations is being left as a practice exercise for the future.
 * All current API's have been reasonably tested to work well.
 */
template <typename K, typename V>
class BinarySearchTree {
public:
    using Compare = std::function<bool(const K& a, const K& b)>;
    BinarySearchTree(const Compare& comparator) : comparator(comparator), root(nullptr), count(0) {}
    
    /*
     * Copy constructor - Leverages a pre-order traversal to copy tree.
     */
    BinarySearchTree(const BinarySearchTree& source) {
        root = recursivelyCopyTree(source.root);
        comparator = source.comparator;
        count = source.count;
    }
    
    /**
     * Destructor - We do a post order traversal to free all memory.
     */
    ~BinarySearchTree()
    {
        clear();
    }
    
    void setValueForKey(const K& key, const V& value)
    {
        TreeNode<K, V>* parent = root;
        TreeNode<K, V>* node = root;
        bool isLeft = false;
        while (node != nullptr) {
            parent = node;
            if (comparator(key, node->key)) {
                node = node->left;
                isLeft = true;
            } else if (comparator(node->key, key)) {
                node = node->right;
                isLeft = false;
            } else {
                node->value = value;
                return;
            }
        }
        if (parent != nullptr) {
            if (isLeft) {
                parent->left = new TreeNode(key, value);
            } else {
                parent->right = new TreeNode(key, value);
            }
        } else {
            root = new TreeNode(key, value);
        }
        count += 1;
    }
    
    std::optional<V> getValueForKey(const K& key)
    {
        TreeNode<K, V>* node = root;
        while (node != nullptr) {
            if (comparator(key, node->key)) {
                node = node->left;
            } else if (comparator(node->key, key)) {
                node = node->right;
            } else {
                return node->value;
            }
        }
        return std::nullopt;
    }
    
    /*
     * Remove is a tricky one to implement but the way this problem approaches it
     * is if a node to be removed has a right child/subtree, we find the next in order
     * successor from the right and swap with the node to be deleted. Because we swap
     * with the in order successor, the in order successor node gets deleted. If the node
     * to delete has only a left child/subtree, we move "up" the left child/subtree to the
     * current node (swap/bubble up) and then delete the target node. Finally if the key/node
     * to delete is a leaf node we blindly delete the target node. This was all relatively
     * difficult to implement iteratively but the logic is sound and works via testing.
     */
    void removeValueForKey(const K& key)
    {
        TreeNode<K, V>* parent = root;
        TreeNode<K, V>* node = root;
        bool isLeft = false;
        while (node != nullptr) {
            if (comparator(key, node->key)) {
                parent = node;
                node = node->left;
                isLeft = true;
            } else if (comparator(node->key, key)) {
                parent = node;
                node = node->right;
                isLeft = false;
            } else {
                break;
            }
        }
        
        if (node != nullptr) {
            if (node->right != nullptr) {
                //find in order successor and "swap"/delete
                TreeNode<K, V>* parent = node;
                TreeNode<K, V>* successorNode = node->right;
                bool isLeft = false;
                while (successorNode->left != nullptr) {
                    parent = successorNode;
                    successorNode = successorNode->left;
                    isLeft = true;
                }
                TreeNode<K, V>* rightSubTree = (successorNode->right != nullptr) ? successorNode->right : nullptr;
                if (isLeft) {
                    parent->left = rightSubTree;
                } else {
                    parent->right = rightSubTree;
                }
                node->value = successorNode->value; //swap
                node->key = successorNode->key;
                delete successorNode;
            } else if (node->left != nullptr) {
                if (isLeft) {
                    parent->left = node->left;
                } else {
                    parent->right = node->left;
                }
                delete node;
            } else {
                if (isLeft) {
                    parent->left = nullptr;
                } else {
                    parent->right = nullptr;
                }
                delete node;
            }
            count -= 1;
        }
    }
    
    /*
     * This API clears/resets our tree leveraging a recursive
     * pre-order traversal.
     */
    void clear()
    {
        count = 0;
        recursivelyFree(root);
        root = nullptr;
    }
    
    int size() { return count; }
    
    TreeNode<K, V>* getOpaqueRoot() { return root; }
    
    /*
     * Performs a simple iterative in-order traversal to
     * enumerate and return all keys and values in the BST in sorted order.
     */
    std::vector<std::pair<K, V>> getAllKeysAndValues()
    {
        std::vector<std::pair<K, V>> keysAndValues;
        iterativelyGetAllKeysAndValues(root, keysAndValues);
        return keysAndValues;
    }
    
    void printAllKeysAndValues() {
        auto keysAndValues = getAllKeysAndValues();
        std::cout << "[ ";
        for (int i = 0; i < keysAndValues.size(); i++) {
            std::cout << "<" << keysAndValues[i].first << "," << keysAndValues[i].second << ">" << " ";
        }
        std::cout << "]" << std::endl;
        std::cout << "Count: " << size() << std::endl;
    }
    
    /*
     * This API performs a recursive pre-order traversal to pretty print
     * the tree including its structure and keys and values. Think UIView.recursiveDescription.
     */
    void prettyPrintTree() {
        std::unordered_map<int, std::string>* tokens = new std::unordered_map<int, std::string>();
        recursivelyPrettyPrintTree(root, 0, tokens);
        std::cout << "Count: " << size() << std::endl << std::endl;
        delete tokens;
    }
    
private:
    TreeNode<K, V> *root;
    Compare comparator;
    int count;
    
    void iterativelyGetAllKeysAndValues(TreeNode<K, V>* node, std::vector<std::pair<K, V>>& result)
    {
        std::stack<TreeNode<K, V>*> nodeStack;
        TreeNode<K, V>* nodePtr = node;
        while (nodePtr != nullptr) {
            nodeStack.push(nodePtr);
            nodePtr = nodePtr->left;
        }
        while (!nodeStack.empty()) {
            nodePtr = nodeStack.top();
            result.push_back({nodePtr->key, nodePtr->value});
            nodeStack.pop();
            nodePtr = nodePtr->right;
            while (nodePtr != nullptr) {
                nodeStack.push(nodePtr);
                nodePtr = nodePtr->left;
            }
        }
    }
    
    void recursivelyGetAllKeysAndValues(TreeNode<K, V>* node, std::vector<std::pair<K, V>>& result)
    {
        if (node == nullptr) {
            return;
        }
        recursivelyGetAllKeysAndValues(node->left, result);
        result.push_back({node->key, node->value});
        recursivelyGetAllKeysAndValues(node->right, result);
    }
    
    void recursivelyFree(TreeNode<K, V> *node)
    {
        if (node == nullptr) {
            return;
        }
        recursivelyFree(node->left);
        recursivelyFree(node->right);
        delete node;
    }
    
    TreeNode<K, V>* recursivelyCopyTree(TreeNode<K, V>* node)
    {
        if (node == nullptr) {
            return nullptr;
        }
        
        TreeNode<K, V> *newNode = new TreeNode<K, V>(node->key, node->value);
        newNode->left = recursivelyCopyTree(node->left);
        newNode->right = recursivelyCopyTree(node->right);
        return newNode;
    }
    
    void recursivelyPrettyPrintTree(TreeNode<K, V>* node,
                                    int level,
                                    std::unordered_map<int, std::string>* tokens)
    {
        if (node == nullptr) { return; }
        std::string prefix = getLevelPrefixString(level, tokens);
        std::cout << prefix << "<" << node->key << "," << node->value << ">" << std::endl;
        (*tokens)[level] = (node->right != nullptr) ? "  |" : "   ";
        recursivelyPrettyPrintTree(node->left, level + 1, tokens);
        (*tokens)[level] = "";
        recursivelyPrettyPrintTree(node->right, level + 1, tokens);
    }
    
    std::string getLevelPrefixString(const int& level,
                                     std::unordered_map<int, std::string>* tokens)
    {
        std::string prefix = "";
        for (int i = 0; i < level; i++) {
            if (i == level - 1) {
                prefix += "  |_____";
            } else {
                std::string prevToken = (*tokens)[i];
                if (prevToken.empty()) {
                    prefix += "        ";
                } else {
                    prefix += (prevToken + "     ");
                }
            }
        }
        return prefix;
    }
};


