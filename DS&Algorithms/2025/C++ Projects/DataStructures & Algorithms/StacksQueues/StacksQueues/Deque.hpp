//
//  Deque.hpp
//  StacksQueues
//
//  Created by Abhay Curam on 5/4/25.
//

#include <optional>
#include "List.hpp"

template <typename T>
class Deque {

public:
    
    Deque() : list(List<T>()) {}
    
    void pushFront(const T& value)
    {
        list.insertFront(value);
    }
    
    void pushBack(const T& value)
    {
        list.insertBack(value);
    }
    
    void popFront()
    {
        list.removeFront();
    }
    
    void popBack()
    {
        list.removeBack();
    }
    
    std::optional<T> front()
    {
        return list.front();
    }
    
    std::optional<T> back()
    {
        return list.back();
    }
    
    
private:
    List<T> list;
    
};
