//
//  Deque.hpp
//  ListStacksQueues
//
//  Created by Abhay Curam on 7/4/24.
//

#include <optional>
using namespace std;

/**
 * Abstract Base class for a Deque Interface.
 */
template <typename T>
class Deque {
public:
    Deque(){}
    virtual ~Deque(){}
    virtual optional<T> front() = 0;
    virtual optional<T> back() = 0;
    virtual optional<T> popFront() = 0;
    virtual optional<T> popBack() = 0;
    virtual void insertFront(T data) = 0;
    virtual void insertBack(T data) = 0;
};
