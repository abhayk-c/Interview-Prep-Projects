//
//  main.cpp
//  BinarySearchTree
//
//  Created by Abhay Curam on 6/24/25.
//

#include <iostream>
#include <string>
#include <vector>
#include "BinarySearchTree.hpp"
#include "BinarySearchTreeIterator.hpp"
#include "BalancedBSTSerializer.hpp"

int main(int argc, const char * argv[]) {
    // insert code here...
    
    BinarySearchTree<int, std::string> bst = BinarySearchTree<int, std::string>([](const int& lhs, const int& rhs){
        return lhs < rhs;
    });
    bst.setValueForKey(5, "A");
    bst.setValueForKey(2, "B");
    bst.setValueForKey(8, "C");
    bst.setValueForKey(0, "D");
    bst.setValueForKey(6, "F");
    bst.setValueForKey(10, "G");
    bst.setValueForKey(-1, "A");
    bst.setValueForKey(1, "B");
    bst.setValueForKey(7, "D");
    bst.setValueForKey(9, "E");
    bst.setValueForKey(11, "F");
    bst.setValueForKey(4, "K");
    bst.setValueForKey(3, "L");
    bst.prettyPrintTree();
    
    std::cout << std::endl;
    bst.printAllKeysAndValues();
    
    std::cout << std::endl;
    std::cout << "Testing Serialization----------------------------------" << std::endl;
    BalancedBSTSerializer<int, std::string> bstSerializer;
    auto serializedTree = bstSerializer.serialize(bst.getOpaqueRoot());
    bstSerializer.printAllKeysAndValues(serializedTree);
    auto root = bstSerializer.deserialize(serializedTree);
    bstSerializer.prettyPrintTree(root);
    std::cout << std::endl;
    std::cout << std::endl;
    
    BinarySearchTree<int, std::string> bst2 = BinarySearchTree<int, std::string>([](const int& lhs, const int& rhs){
        return lhs < rhs;
    });
    bst2.setValueForKey(5, "A");
    bst2.setValueForKey(8, "B");
    bst2.setValueForKey(10, "C");
    bst2.setValueForKey(11, "D");
    bst2.setValueForKey(12, "F");
    bst2.prettyPrintTree();
    bst2.printAllKeysAndValues();
    auto serializedTree2 = bstSerializer.serialize(bst2.getOpaqueRoot());
    bstSerializer.printAllKeysAndValues(serializedTree2);
    auto root2 = bstSerializer.deserialize(serializedTree2);
    bstSerializer.prettyPrintTree(root2);
    std::cout << std::endl;
    
    /*auto bstIterator = BinarySearchTreeIterator<int, std::string>(bst.getOpaqueRoot());
    auto keyValue = bstIterator.begin();
    while (keyValue.has_value()) {
        std::cout << "<" << keyValue.value().first << "," << keyValue.value().second << ">" << " ";
        keyValue = bstIterator.getNext();
    }
    std::cout << std::endl;
    keyValue = bstIterator.begin();
    while (keyValue.has_value()) {
        std::cout << "<" << keyValue.value().first << "," << keyValue.value().second << ">" << " ";
        keyValue = bstIterator.getNext();
    }
    std::cout << std::endl;
    std::cout << std::endl;
    std::cout << "Testing Leetcode Iterator---------------------" << std::endl;
    
    BSTTreeNode* nodeOne = new BSTTreeNode(1);
    BSTTreeNode* nodeTwo = new BSTTreeNode(2, nodeOne, nullptr);
    BSTIterator iterator = BSTIterator(nodeTwo);
    
    std::cout << iterator.next() << std::endl;
    std::cout << iterator.next() << std::endl;
    std::cout << iterator.hasNext() << std::endl;*/
    
    return 0;
}
