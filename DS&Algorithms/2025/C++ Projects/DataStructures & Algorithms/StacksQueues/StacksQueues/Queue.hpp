//
//  Queue.hpp
//  StacksQueues
//
//  Created by Abhay Curam on 5/4/25.
//

#include <optional>
#include "List.hpp"

template <typename T>
class Queue {
    
public:
    
    Queue() : list(List<T>()) {}
    
    void enqueue(const T& value)
    {
        list.insertBack(value);
    }
    
    void dequeue()
    {
        list.removeFront();
    }
    
    std::optional<T> front()
    {
        return list.front();
    }
    
    std::optional<T> back()
    {
        return list.back();
    }
    
    const int size()
    {
        return list.size();
    }
    
    bool isEmpty()
    {
        return size() == 0;
    }
    
    
private:
    List<T> list;
    
};
