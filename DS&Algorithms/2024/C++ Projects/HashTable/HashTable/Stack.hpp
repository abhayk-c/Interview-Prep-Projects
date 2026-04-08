//
//  Stack.hpp
//  ListStacksQueues
//
//  Created by Abhay Curam on 7/5/24.
//

#include <optional>
using namespace std;

/**
 * Abstract Base Class for a Stack interface.
 */
template <typename T>
class Stack {
public:
    Stack(){}
    virtual ~Stack(){}
    virtual optional<T> top() = 0;
    virtual void push(T data) = 0;
    virtual optional<T> pop() = 0;
};
