//
//  main.cpp
//  List
//
//  Created by Abhay Curam on 4/24/25.
//

#include <iostream>
#include <optional>
#include <list>
#include "List.hpp"

int main(int argc, const char * argv[]) {
    
    std::list<int> stlIntegerList;
    //inserting at front and back of list
    stlIntegerList.push_front(4);
    stlIntegerList.push_front(3);
    stlIntegerList.push_back(5);
    stlIntegerList.push_back(6);
    //removing from front and back
    stlIntegerList.pop_back();
    stlIntegerList.pop_front();
    
    //iterating through list
    //Prints: [4, 5]
    for (auto it = stlIntegerList.begin(); it != stlIntegerList.end(); it++) {
        std::cout << *it << std::endl;
    }
    //iterator based insertion/removal
    stlIntegerList.insert(stlIntegerList.begin(), 0);
    stlIntegerList.erase(stlIntegerList.begin());
    
    
    
    
    
    /**
     * Front list insertion and removal tests
     */
    std::cout << "!!~~~Front list insertion and removal tests~~~!!" << std::endl;
    List<int> integerList = List<int>();
    std::cout << "List size before insertions: " << integerList.size() << std::endl;
    std::cout << "List front element before insertions: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back element before insertions: " << integerList.back().value_or(-1) << std::endl;
    std::cout << "-----Inserting Elements in front-----" << std::endl;
    integerList.insertFront(1);
    integerList.insertFront(2);
    integerList.insertFront(3);
    integerList.insertFront(4);
    std::cout << "Forward Iterating list: " << std::endl;
    for (auto it = integerList.begin(); it != integerList.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating list: " << std::endl;
    for (auto it = integerList.rbegin(); it != integerList.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size after insertions: " << integerList.size() << std::endl;
    std::cout << "List front element after insertions: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back element after insertions: " << integerList.back().value_or(-1) << std::endl;
    
    std::cout << "-----Removing Elements from front-----" << std::endl;
    while (integerList.begin() != integerList.end()) {
        integerList.removeFront();
        std::cout << "List front element after removal: " << integerList.front().value_or(-1) << std::endl;
        std::cout << "List back element after removal: " << integerList.back().value_or(-1) << std::endl;
        std::cout << "List size: " << integerList.size() << std::endl;
    }
    // One more removal to test edge case of removing from front of empty list
    std::cout << "-----Removing front element from empty list-----" << std::endl;
    integerList.removeFront();
    integerList.removeFront();
    integerList.removeFront();
    std::cout << "List front: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back: " << integerList.back().value_or(-1) << std::endl;
    std::cout << "List size: " << integerList.size() << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    
    /**
     * Back of list insertion and removal tests
     */
    std::cout << "!!~~~Back of list insertion and removal tests~~~!!" << std::endl;
    std::cout << "List size before insertions: " << integerList.size() << std::endl;
    std::cout << "List front element before insertions: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back element before insertions: " << integerList.back().value_or(-1) << std::endl;
    std::cout << "-----Inserting Elements in back-----" << std::endl;
    integerList.insertBack(1);
    integerList.insertBack(2);
    integerList.insertBack(3);
    integerList.insertBack(4);
    std::cout << "Forward Iterating list: " << std::endl;
    for (auto it = integerList.begin(); it != integerList.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating list: " << std::endl;
    for (auto it = integerList.rbegin(); it != integerList.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size after insertions: " << integerList.size() << std::endl;
    std::cout << "List front element after insertions: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back element after insertions: " << integerList.back().value_or(-1) << std::endl;
    std::cout << "-----Removing Elements from back-----" << std::endl;
    while (integerList.begin() != integerList.end()) {
        integerList.removeBack();
        std::cout << "List front element after removal: " << integerList.front().value_or(-1) << std::endl;
        std::cout << "List back element after removal: " << integerList.back().value_or(-1) << std::endl;
        std::cout << "List size: " << integerList.size() << std::endl;
    }
    // One more removal to test edge case of removing from front of empty list
    std::cout << "-----Removing back element from empty list-----" << std::endl;
    integerList.removeBack();
    integerList.removeBack();
    integerList.removeBack();
    std::cout << "List front: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back: " << integerList.back().value_or(-1) << std::endl;
    std::cout << "List size: " << integerList.size() << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    
    /**
     * Interleaving back and front insertion/removal tests
     */
    std::cout << "!!~~~Interleaving front and back insertion/removals tests~~~!!" << std::endl;
    integerList.insertBack(7);
    integerList.insertBack(8);
    integerList.insertBack(9);
    integerList.insertBack(10);
    integerList.insertFront(6);
    integerList.insertFront(5);
    integerList.insertFront(4);
    integerList.insertBack(11);
    integerList.insertBack(12);
    integerList.insertBack(13);
    integerList.insertFront(3);
    integerList.insertFront(2);
    integerList.insertFront(1);
    integerList.insertFront(0);
    std::cout << "Forward Iterating list: " << std::endl;
    for (auto it = integerList.begin(); it != integerList.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating list: " << std::endl;
    for (auto it = integerList.rbegin(); it != integerList.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size after interleaved insertions: " << integerList.size() << std::endl;
    std::cout << "List front element after insertions: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back element after insertions: " << integerList.back().value_or(-1) << std::endl;
    std::cout << "-----Interleaving removals from front and back-----" << std::endl;
    integerList.removeFront();
    integerList.removeBack();
    integerList.removeBack();
    integerList.removeFront();
    integerList.removeBack();
    integerList.removeFront();
    integerList.removeFront();
    std::cout << "Forward Iterating list: " << std::endl;
    for (auto it = integerList.begin(); it != integerList.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating list: " << std::endl;
    for (auto it = integerList.rbegin(); it != integerList.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size after interleaved removals: " << integerList.size() << std::endl;
    std::cout << "List front element after interleaved removals: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back element after interleaved removals: " << integerList.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    
    /**
     * Clearing of list tests
     */
    std::cout << "!!~~~Clearing of list tests~~~!!" << std::endl;
    integerList.clear();
    std::cout << "List size after clearing non-empty list: " << integerList.size() << std::endl;
    std::cout << "List front element after clearing non-empty list: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back element after clearing non-empty list: " << integerList.back().value_or(-1) << std::endl;
    integerList.clear();
    std::cout << "List size after clearing empty list: " << integerList.size() << std::endl;
    std::cout << "List front element after clearing empty list: " << integerList.front().value_or(-1) << std::endl;
    std::cout << "List back element after clearing empty list: " << integerList.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    
    /**
     * Copy Constructor Tests
     */
    std::cout << "!!~~~Copy Constructor tests~~~!!" << std::endl;
    List<int> integerListA = List<int>();
    integerListA.insertFront(100);
    integerListA.insertFront(99);
    integerListA.insertFront(98);
    integerListA.insertBack(101);
    integerListA.insertBack(102);
    integerListA.insertBack(103);
    integerListA.insertFront(97);
    integerListA.insertFront(96);
    integerListA.insertFront(95);
    std::cout << "Forward Iterating original list: " << std::endl;
    for (auto it = integerListA.begin(); it != integerListA.end(); it++) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "Reverse Iterating original list: " << std::endl;
    for (auto it = integerListA.rbegin(); it != integerListA.rend(); it--) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "List size of original list: " << integerListA.size() << std::endl;
    std::cout << "Original List front element: " << integerListA.front().value_or(-1) << std::endl;
    std::cout << "Original List back element: " << integerListA.back().value_or(-1) << std::endl;
    
    std::cout << "-----------Invoking copy constructor on non-empty list----------" << std::endl;
    List<int> integerListB = integerListA;
    std::cout << "Original List Memory Address: " << &integerListA << std::endl;
    std::cout << "Newly Copied List Memory Address: " << &integerListB << std::endl;
    std::cout << "Forward Iterating newly copied list: " << std::endl;
    for (auto it = integerListB.begin(); it != integerListB.end(); it++) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "Reverse Iterating newly copied list: " << std::endl;
    for (auto it = integerListB.rbegin(); it != integerListB.rend(); it--) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "List size of newly copied list: " << integerListB.size() << std::endl;
    std::cout << "Copied List front element: " << integerListB.front().value_or(-1) << std::endl;
    std::cout << "Copied List back element: " << integerListB.back().value_or(-1) << std::endl;
    
    std::cout << "-----------Invoking copy constructor on empty list----------" << std::endl;
    List<int> integerListC = List<int>();
    List<int> integerListD = integerListC;
    std::cout << "Forward Iterating original empty list: " << std::endl;
    for (auto it = integerListC.begin(); it != integerListC.end(); it++) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "Reverse Iterating original empty list: " << std::endl;
    for (auto it = integerListC.rbegin(); it != integerListC.rend(); it--) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "List size of original empty list: " << integerListC.size() << std::endl;
    std::cout << "Original empty List front element: " << integerListC.front().value_or(-1) << std::endl;
    std::cout << "Original empty List back element: " << integerListC.back().value_or(-1) << std::endl;
    std::cout << "Original Empty List Memory Address: " << &integerListC << std::endl;
    std::cout << "Newly Copied List Memory Address: " << &integerListD << std::endl;
    std::cout << "Forward Iterating newly copied list: " << std::endl;
    for (auto it = integerListD.begin(); it != integerListD.end(); it++) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "Reverse Iterating newly copied list: " << std::endl;
    for (auto it = integerListD.rbegin(); it != integerListD.rend(); it--) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "List size of newly copied list: " << integerListD.size() << std::endl;
    std::cout << "Copied List front element: " << integerListD.front().value_or(-1) << std::endl;
    std::cout << "Copied List back element: " << integerListD.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    
    
    /**
     * Overloaded Assignment Operator Tests
     */
    std::cout << "!!~~~Copy on Assignment tests~~~!!" << std::endl;
    List<int> integerListT, integerListY;
    integerListT = List<int>();
    integerListT.insertFront(5);
    integerListT.insertFront(4);
    integerListT.insertFront(3);
    integerListT.insertBack(6);
    integerListT.insertBack(7);
    integerListT.insertBack(8);
    integerListT.insertFront(2);
    integerListT.insertFront(1);
    integerListT.insertFront(0);
    std::cout << "Forward Iterating original list: " << std::endl;
    for (auto it = integerListT.begin(); it != integerListT.end(); it++) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "Reverse Iterating original list: " << std::endl;
    for (auto it = integerListT.rbegin(); it != integerListT.rend(); it--) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "List size of original list: " << integerListT.size() << std::endl;
    std::cout << "Original List front element: " << integerListT.front().value_or(-1) << std::endl;
    std::cout << "Original List back element: " << integerListT.back().value_or(-1) << std::endl;
    
    std::cout << "-----------Invoking copy on assignment on non-empty list----------" << std::endl;
    integerListY = integerListT;
    std::cout << "Original List Memory Address: " << &integerListT << std::endl;
    std::cout << "Newly Copied List Memory Address: " << &integerListY << std::endl;
    std::cout << "Forward Iterating newly copied list: " << std::endl;
    for (auto it = integerListY.begin(); it != integerListY.end(); it++) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "Reverse Iterating newly copied list: " << std::endl;
    for (auto it = integerListY.rbegin(); it != integerListY.rend(); it--) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "List size of newly copied list: " << integerListY.size() << std::endl;
    std::cout << "Copied List front element: " << integerListY.front().value_or(-1) << std::endl;
    std::cout << "Copied List back element: " << integerListY.back().value_or(-1) << std::endl;
    
    std::cout << "-----------Invoking copy on assignment on empty list----------" << std::endl;
    List<int> integerListZ, integerListX;
    integerListX = List<int>();
    integerListZ = integerListX;
    std::cout << "Forward Iterating original empty list: " << std::endl;
    for (auto it = integerListX.begin(); it != integerListX.end(); it++) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "Reverse Iterating original empty list: " << std::endl;
    for (auto it = integerListX.rbegin(); it != integerListX.rend(); it--) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "List size of original empty list: " << integerListX.size() << std::endl;
    std::cout << "Original empty List front element: " << integerListX.front().value_or(-1) << std::endl;
    std::cout << "Original empty List back element: " << integerListX.back().value_or(-1) << std::endl;
    std::cout << "Original Empty List Memory Address: " << &integerListX << std::endl;
    std::cout << "Newly Copied List Memory Address: " << &integerListZ << std::endl;
    std::cout << "Forward Iterating newly copied list: " << std::endl;
    for (auto it = integerListZ.begin(); it != integerListZ.end(); it++) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "Reverse Iterating newly copied list: " << std::endl;
    for (auto it = integerListZ.rbegin(); it != integerListZ.rend(); it--) {
        std::cout << "data: " << it->data << ", Mem Address: " << &(*it) << std::endl;
    }
    std::cout << "List size of newly copied list: " << integerListZ.size() << std::endl;
    std::cout << "Copied List front element: " << integerListZ.front().value_or(-1) << std::endl;
    std::cout << "Copied List back element: " << integerListZ.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    
    
    /**
     * Iterator Based Insertion Tests
     */
    std::cout << "!!~~~Iterator Based Insertion tests~~~!!" << std::endl;
    List<int> l1, l2, l3, l4, l5, l6, l7;
    l1 = List<int>();
    l2 = List<int>();
    l3 = List<int>();
    l4 = List<int>();
    
    l1.insertAt(l1.begin(), 3);
    l1.insertAt(l1.begin(), 2);
    l1.insertAt(l1.begin(), 1);
    l1.insertAt(l1.begin(), 0);
    std::cout << "Forward Iterating l1, repeated inserts at begin() of list" << std::endl;
    for (auto it = l1.begin(); it != l1.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating l1, repeated inserts at begin() of list" << std::endl;
    for (auto it = l1.rbegin(); it != l1.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l1: " << l1.size() << std::endl;
    std::cout << "l1 front element: " << l1.front().value_or(-1) << std::endl;
    std::cout << "l1 back element: " << l1.back().value_or(-1) << std::endl;
    
    l2.insertAt(l2.end(), 3);
    l2.insertAt(l2.end(), 2);
    l2.insertAt(l2.end(), 1);
    l2.insertAt(l2.end(), 0);
    std::cout << "Forward Iterating l2, repeated inserts at end() of list" << std::endl;
    for (auto it = l2.begin(); it != l2.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating l2, repeated inserts at end() of list" << std::endl;
    for (auto it = l2.rbegin(); it != l2.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l2: " << l2.size() << std::endl;
    std::cout << "l2 front element: " << l2.front().value_or(-1) << std::endl;
    std::cout << "l2 back element: " << l2.back().value_or(-1) << std::endl;
    
    l3.insertAt(l3.rbegin(), 5);
    l3.insertAt(l3.rbegin(), 6);
    l3.insertAt(l3.rbegin(), 7);
    l3.insertAt(l3.rbegin(), 8);
    
    /**
     * Also attempting to insert at rend(), this should be a no-op
     */
    l3.insertAt(l3.rend(), 0);
    l3.insertAt(l3.rend(), 1);
    
    /**
     * Attempting to insert at nullptr given forward direction and reverse.
     * If iterating forwards this should be treated as end() and result in a valid insertion.
     * If iterating backwards this should be treated as rend() and result in a no-op.
     */
    auto f_it = List<int>::ListIterator(nullptr, List<int>::ListIterator::forward);
    auto r_it = List<int>::ListIterator(nullptr, List<int>::ListIterator::reverse);
    l3.insertAt(f_it, 4);
    l3.insertAt(r_it, 0);
    
    std::cout << "Forward Iterating l3, repeated inserts at rbegin() of list" << std::endl;
    for (auto it = l3.begin(); it != l3.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating l3, repeated inserts at rbegin() of list" << std::endl;
    for (auto it = l3.rbegin(); it != l3.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l3: " << l3.size() << std::endl;
    std::cout << "l3 front element: " << l3.front().value_or(-1) << std::endl;
    std::cout << "l3 back element: " << l3.back().value_or(-1) << std::endl;
    
    std::cout << std::endl;
    std::cout << "------------Testing insertions within list and boundaries using forward ++ iterator----------" << std::endl;
    l4.insertBack(1);
    l4.insertBack(3);
    l4.insertBack(5);
    l4.insertBack(6);
    l4.insertBack(8);
    auto it1 = l4.begin();
    it1++;
    l4.insertAt(it1, 2);
    it1++;
    l4.insertAt(it1, 4);
    it1++;
    it1++;
    l4.insertAt(it1, 7);
    it1++;
    l4.insertAt(it1, 9);
    it1++;
    l4.insertAt(it1, 10);
    std::cout << "Forward Iterating l4, insertions using ++ forwards iterator" << std::endl;
    for (auto it = l4.begin(); it != l4.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating l4, insertions using ++ forwards iterator" << std::endl;
    for (auto it = l4.rbegin(); it != l4.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    
    std::cout << std::endl;
    std::cout << "------------Testing insertions within list and boundaries using reverse -- iterator----------" << std::endl;
    l5.insertBack(1);
    l5.insertBack(3);
    l5.insertBack(5);
    l5.insertBack(6);
    l5.insertBack(8);
    auto it2 = l5.rbegin();
    l5.insertAt(it2, 7);
    it2--;
    it2--;
    it2--;
    l5.insertAt(it2, 4);
    it2--;
    it2--;
    l5.insertAt(it2, 2);
    it2--;
    it2--;
    l5.insertAt(it2, 0);
    it2--;
    it2--;
    l5.insertAt(it2, -1);
    it2--;
    l5.insertAt(it2, -2);
    std::cout << "Forward Iterating l5, insertions using -- reverse iterator" << std::endl;
    for (auto it = l5.begin(); it != l5.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating l5, insertions using -- reverse iterator" << std::endl;
    for (auto it = l5.rbegin(); it != l5.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l5: " << l5.size() << std::endl;
    std::cout << "l5 front element: " << l5.front().value_or(-1) << std::endl;
    std::cout << "l5 back element: " << l5.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    
    /**
     * Iterator Based Removal Tests
     */
    std::cout << "!!~~~Iterator Based Removal tests~~~!!" << std::endl;
    std::cout << "------------Testing removals within list and boundaries using forward ++ iterator----------" << std::endl;
    l6.insertBack(0);
    l6.insertBack(1);
    l6.insertBack(2);
    l6.insertBack(3);
    l6.insertBack(4);
    l6.insertBack(5);
    l6.insertBack(6);
    l6.insertBack(7);
    l6.insertBack(8);
    l6.insertBack(9);
    std::cout << "Forward Iterating l6, original list:" << std::endl;
    for (auto it = l6.begin(); it != l6.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Forward Iterating l6, original list:" << std::endl;
    for (auto it = l6.rbegin(); it != l6.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l6: " << l6.size() << std::endl;
    std::cout << "l6 front element: " << l6.front().value_or(-1) << std::endl;
    std::cout << "l6 back element: " << l6.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    std::cout << "------------Now removing elements----------" << std::endl;
    auto l6_it = l6.begin();
    l6.removeAt(l6_it);
    l6_it = l6.begin();
    l6_it++;
    l6_it++;
    l6_it++;
    l6.removeAt(l6_it);
    l6_it = l6.begin();
    l6_it++;
    l6_it++;
    l6_it++;
    l6_it++;
    l6_it++;
    l6.removeAt(l6_it);
    l6_it = l6.begin();
    l6_it++;
    l6_it++;
    l6_it++;
    l6_it++;
    l6_it++;
    l6_it++;
    l6.removeAt(l6_it);
    l6_it = l6.begin();
    l6_it++;
    l6_it++;
    l6_it++;
    l6_it++;
    l6_it++;
    l6_it++;
    l6.removeAt(l6_it);
    l6_it++;
    l6.removeAt(l6_it);
    l6_it = l6.end();
    l6.removeAt(l6_it);
    l6_it++;
    l6.removeAt(l6_it);
    std::cout << "Forward Iterating l6, removals using ++ forwards iterator" << std::endl;
    for (auto it = l6.begin(); it != l6.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating l6, removals using ++ forwards iterator" << std::endl;
    for (auto it = l6.rbegin(); it != l6.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l6: " << l6.size() << std::endl;
    std::cout << "l6 front element: " << l6.front().value_or(-1) << std::endl;
    std::cout << "l6 back element: " << l6.back().value_or(-1) << std::endl;
    std::cout << "------------Now clearing list with repeated removals at begin()----------" << std::endl;
    l6.removeAt(l6.begin());
    l6.removeAt(l6.begin());
    l6.removeAt(l6.begin());
    l6.removeAt(l6.begin());
    l6.removeAt(l6.begin());
    l6.removeAt(l6.begin());
    std::cout << "Forward Iterating l6 after clearing list at begin()" << std::endl;
    for (auto it = l6.begin(); it != l6.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating l6 after clearing list at begin()" << std::endl;
    for (auto it = l6.rbegin(); it != l6.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l6: " << l6.size() << std::endl;
    std::cout << "l6 front element: " << l6.front().value_or(-1) << std::endl;
    std::cout << "l6 back element: " << l6.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    
    std::cout << "------------Testing removals within list and boundaries using reverse -- iterator----------" << std::endl;
    l7.insertBack(1);
    l7.insertBack(2);
    l7.insertBack(3);
    l7.insertBack(4);
    l7.insertBack(5);
    l7.insertBack(6);
    std::cout << "Forward Iterating l7, original list:" << std::endl;
    for (auto it = l7.begin(); it != l7.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Forward Iterating l7, original list:" << std::endl;
    for (auto it = l7.rbegin(); it != l7.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l7: " << l7.size() << std::endl;
    std::cout << "l7 front element: " << l7.front().value_or(-1) << std::endl;
    std::cout << "l7 back element: " << l7.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    std::cout << "------------Now removing elements----------" << std::endl;
    std::cout << std::endl;
    
    auto it = l7.rbegin();
    l7.removeAt(it);
    it = l7.rbegin();
    it--;
    it--;
    l7.removeAt(it);
    it = l7.rbegin();
    it--;
    it--;
    it--;
    l7.removeAt(it);
    it = l7.rbegin();
    it--;
    it--;
    it--;
    l7.removeAt(it);
    it--;
    l7.removeAt(it);
    it = l7.rend();
    l7.removeAt(it);
    it--;
    l7.removeAt(it);
    std::cout << "Forward Iterating l7, removals using -- reverse iterator" << std::endl;
    for (auto it = l7.begin(); it != l7.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating l7, removals using -- reverse iterator" << std::endl;
    for (auto it = l7.rbegin(); it != l7.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l7: " << l7.size() << std::endl;
    std::cout << "l7 front element: " << l7.front().value_or(-1) << std::endl;
    std::cout << "l7 back element: " << l7.back().value_or(-1) << std::endl;
    std::cout << "------------Now clearing list with repeated removals at rbegin()----------" << std::endl;
    l7.removeAt(l7.rbegin());
    l7.removeAt(l7.rbegin());
    l7.removeAt(l7.rbegin());
    std::cout << "Forward Iterating l7 after clearing list at rbegin()" << std::endl;
    for (auto it = l7.begin(); it != l7.end(); it++) {
        std::cout << it->data << std::endl;
    }
    std::cout << "Reverse Iterating l7 after clearing list at rbegin()" << std::endl;
    for (auto it = l7.rbegin(); it != l7.rend(); it--) {
        std::cout << it->data << std::endl;
    }
    std::cout << "List size of l7: " << l7.size() << std::endl;
    std::cout << "l7 front element: " << l7.front().value_or(-1) << std::endl;
    std::cout << "l7 back element: " << l7.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    
    return 0;
}


