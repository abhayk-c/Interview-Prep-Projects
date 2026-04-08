//
//  TreeNode.hpp
//  BinarySearchTree
//
//  Created by Abhay Curam on 6/25/25.
//
#pragma once

template <typename K, typename V>
class BinarySearchTree;

template <typename K, typename V>
class BinarySearchTreeIterator;

template <typename K, typename V>
class BalancedBSTSerializer;

template <typename K, typename V>
struct TreeNode {
private:
    K key;
    V value;
    TreeNode* left;
    TreeNode* right;
    TreeNode(const K& key, const V& value) : key(key), value(value), left(nullptr), right(nullptr) {}
    friend class BinarySearchTree<K, V>;
    friend class BinarySearchTreeIterator<K, V>;
    friend class BalancedBSTSerializer<K, V>;
};
