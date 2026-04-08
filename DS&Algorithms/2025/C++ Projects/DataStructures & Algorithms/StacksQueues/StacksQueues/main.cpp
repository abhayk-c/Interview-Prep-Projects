//
//  main.cpp
//  StacksQueues
//
//  Created by Abhay Curam on 5/4/25.
//

#include <iostream>
#include "Stack.hpp"
#include "Queue.hpp"
#include "Deque.hpp"

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    
    //write tests here
    Stack<int> stack = Stack<int>();
    std::cout << "!!!!Stack Tests!!!!!" << std::endl;
    std::cout << "-----Verifying empty stack:-------" << std::endl;
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    std::cout << "-----Adding Elements: [1, 2, 3, 4] to Stack------" <<std::endl;
    stack.push(1);
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    stack.push(2);
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    stack.push(3);
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    stack.push(4);
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    std::cout << "-----Popping elements from Stack to verify ordering------" <<std::endl;
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    stack.pop();
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    stack.pop();
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    stack.pop();
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    stack.pop();
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    std::cout << "-----Popping from empty stack:--------" << std::endl;
    stack.pop();
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    stack.pop();
    std::cout << "Stack size: " << stack.size() << std::endl;
    std::cout << "Stack top: " << stack.top().value_or(-1) << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    
    Queue<int> queue = Queue<int>();
    std::cout << "!!!!Queue Tests!!!!!" << std::endl;
    std::cout << "-----Verifying empty queue:-------" << std::endl;
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    std::cout << "-----Adding Elements: [1, 2, 3, 4] to Queue------" <<std::endl;
    queue.enqueue(1);
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    queue.enqueue(2);
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    queue.enqueue(3);
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    queue.enqueue(4);
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    std::cout << "-----Popping elements from Queue to verify ordering------" <<std::endl;
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    queue.dequeue();
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    queue.dequeue();
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    queue.dequeue();
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    queue.dequeue();
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    std::cout << "-----Popping from empty queue:--------" << std::endl;
    queue.dequeue();
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    queue.dequeue();
    std::cout << "Queue size: " << queue.size() << std::endl;
    std::cout << "Queue front: " << queue.front().value_or(-1) << std::endl;
    std::cout << "Queue back: " << queue.back().value_or(-1) << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    
    /**
     * I am not writing tests for a Deque, it literally just wraps the same exact
     * API's for a doubly linked list that we have already tested. It just shims to it.
     */
    
    return 0;
}
