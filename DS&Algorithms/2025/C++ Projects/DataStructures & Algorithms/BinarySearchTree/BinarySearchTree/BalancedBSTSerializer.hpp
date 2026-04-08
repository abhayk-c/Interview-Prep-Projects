//
//  BalancedBSTSerializer.hpp
//  BinarySearchTree
//
//  Created by Abhay Curam on 6/26/25.
//

#include "TreeNode.hpp"
#include <vector>

template <typename K, typename V>
class BalancedBSTSerializer
{
public:
    std::vector<std::pair<K, V>> serialize(TreeNode<K, V>* root)
    {
        std::vector<std::pair<K, V>> keysAndValues;
        recursivelyGetAllKeysAndValues(root, keysAndValues);
        return keysAndValues;
    }
    
    // It is up to the caller to manage/free the tree's memory.
    // A cleanup API could have easily been provided.
    TreeNode<K, V>* deserialize(const std::vector<std::pair<K, V>>& keysAndValues)
    {
        if (keysAndValues.empty()) { return nullptr; }
        return recursivelyDeserialize(keysAndValues, 0, keysAndValues.size() - 1);
    }
    
    /*
     * These functions are duplicated from the BinarySearchTree object, this is just for
     * ease of testing, verification, and debugging purposes.
     */
    void prettyPrintTree(TreeNode<K, V> *tree) {
        std::cout << "Deserialized Tree: " << std::endl;
        std::unordered_map<int, std::string>* tokens = new std::unordered_map<int, std::string>();
        recursivelyPrettyPrintTree(tree, 0, tokens);
        delete tokens;
    }
    
    void printAllKeysAndValues(const std::vector<std::pair<K, V>>& keysAndValues) {
        std::cout << "Serialized Tree: ";
        std::cout << "[ ";
        for (int i = 0; i < keysAndValues.size(); i++) {
            std::cout << "<" << keysAndValues[i].first << "," << keysAndValues[i].second << ">" << " ";
        }
        std::cout << "]" << std::endl;
        std::cout << "Count: " << keysAndValues.size() << std::endl;
    }
    
private:
    void recursivelyGetAllKeysAndValues(TreeNode<K, V>* node, std::vector<std::pair<K, V>>& result)
    {
        if (node == nullptr) {
            return;
        }
        recursivelyGetAllKeysAndValues(node->left, result);
        result.push_back({node->key, node->value});
        recursivelyGetAllKeysAndValues(node->right, result);
    }
    
    TreeNode<K, V>* recursivelyDeserialize(const std::vector<std::pair<K, V>>& keysAndValues,
                                           const int& startIndex,
                                           const int& endIndex)
    {
        if (startIndex > endIndex) { return nullptr; }
        int midIndex = startIndex + ((endIndex - startIndex) / 2);
        auto currentKeyValue = keysAndValues[midIndex];
        TreeNode<K, V>* node = new TreeNode<K, V>(currentKeyValue.first, currentKeyValue.second);
        node->left = recursivelyDeserialize(keysAndValues, startIndex, midIndex - 1);
        node->right = recursivelyDeserialize(keysAndValues, midIndex + 1, endIndex);
        return node;
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

