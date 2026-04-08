//
//  Stack.hpp
//  StacksQueues
//
//  Created by Abhay Curam on 5/4/25.
//

#import "List.hpp"
#include <optional>

template <typename T>
class Stack {

public:
    
    Stack() : list(List<T>()) {}
    
    void push(const T& value)
    {
        list.insertBack(value);
    }
    
    void pop()
    {
        list.removeBack();
    }
    
    std::optional<T> top()
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
