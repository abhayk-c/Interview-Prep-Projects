//
//  main.cpp
//  ListStacksQueues
//
//  Created by Abhay Curam on 7/4/24.
//
#include <iostream>
#include <vector>
#include <optional>
#include <string>
#include <iterator>
#include <functional>
#include "List.hpp"
using namespace std;

/**
 * NOTE: ------
 * The design pattern approach I took to this problem was to create a
 * single Doubly Linked List class that implements different Abstract Base Class (Interfaces)
 * for Stack, Queue, and Deque behavior.
 * I expose a C-Style Creation Factory to create different flavors of each data structure
 * so that I can hide the concrete implementation detail from the client (only return interface
 * to client). I could make it a bit more OOP by replacing the C-Style Creation API's with
 * a Factory object itself that can "build" different flavors of each data structure on the
 * "heap" or Stack for example. But felt like overkill....
 *
 * This approach works but in retrospect I would have just followed Composition pattern,
 * it got quite complicated so thats probably why the rule of thumb "favor composition" exists.
 * If I were to do this over I would just create new types/Classes that wrap and compose my List.
 * Following this design pattern became even more of a nightmare in Swift and my Factory function
 * to return a protocol and "obfsucate" the subclass implementation doesn't even compile.
 * I leave that as a exercise for some later point/time.
 *
 */

int main(int argc, const char * argv[]) {
    Deque<string> *integerDeque = CreateDeque<string>();
    integerDeque->insertFront("4");
    integerDeque->insertFront("3");
    integerDeque->insertFront("2");
    integerDeque->insertFront("1");
    integerDeque->insertBack("5");
    integerDeque->insertBack("6");
    integerDeque->insertBack("7");
    
    for (auto element = integerDeque->popFront(); element.has_value(); element = integerDeque->popFront()) {
        cout << element.value() << endl;
    }
    auto emptyDequeElement = integerDeque->popFront();
    cout << (emptyDequeElement.has_value() ? emptyDequeElement.value() : "_") << endl;
    
    Stack<int> *integerStack = CreateStack<int>();
    integerStack->push(1);
    integerStack->push(2);
    integerStack->push(3);
    for (auto element = integerStack->pop(); element.has_value(); element = integerStack->pop()) {
        cout << element.value() << endl;
    }
    auto emptyStackElement = integerStack->pop();
    cout << (emptyStackElement.has_value() ? to_string(emptyStackElement.value()) : "_") << endl;
    
    Queue<int> *integerQueue = CreateQueue<int>();
    integerQueue->enqueue(1);
    integerQueue->enqueue(2);
    integerQueue->enqueue(3);
    for (auto element = integerQueue->dequeue(); element.has_value(); element = integerQueue->dequeue()) {
        cout << element.value() << endl;
    }
    auto emptyQueueElement = integerQueue->dequeue();
    cout << (emptyQueueElement.has_value() ? to_string(emptyQueueElement.value()) : "_") << endl;
    
    return 0;
}
