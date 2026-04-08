//
//  Queue.hpp
//  ListStacksQueues
//
//  Created by Abhay Curam on 7/5/24.
//

#include <optional>
using namespace std;

/**
 * Abstract Base Class for a Queue interface.
 */
template <typename T>
class Queue {
public:
    Queue(){}
    virtual ~Queue(){}
    virtual void enqueue(T data) = 0;
    virtual optional<T> dequeue() = 0;
    virtual optional<T> front() = 0;
    virtual optional<T> back() = 0;
};
