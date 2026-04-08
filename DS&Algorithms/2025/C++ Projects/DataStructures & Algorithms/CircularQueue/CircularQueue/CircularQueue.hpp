//
//  CircularQueue.hpp
//  CircularQueue
//
//  Created by Abhay Curam on 5/9/25.
//

#include <optional>

/**
 * This is a queue implemented as a fixed-size circular ring buffer.
 * This could have been easily modified to support dynamic resizing but I didn't add it.
 * Very trivial to do.
 */
template <typename T>
class CircularQueue {

public:
    CircularQueue(int k) {
        if (k <= 0) { throw std::invalid_argument("Size must be greater than 0"); }
        capacity = k;
        count = 0;
        buffer = new std::optional<T>[capacity];
        headIndex = 0;
        tailIndex = 0;
    }
    
    ~CircularQueue() {
        delete[] buffer;
    }
    
    bool enqueue(const T& value) {
        if (!buffer[tailIndex].has_value()) {
            buffer[tailIndex] = value;
            //advance pointer or wrap around
            tailIndex = (tailIndex + 1 < capacity) ? tailIndex + 1 : 0;
            count++;
            return true;
        }
        return false;
    }
    
    bool dequeue() {
        if (buffer[headIndex].has_value()) {
            buffer[headIndex] = std::nullopt;
            //advance pointer or wrap around
            headIndex = (headIndex + 1 < capacity) ? headIndex + 1 : 0;
            count--;
            return true;
        }
        return false;
    }
    
    std::optional<T> front() {
        return (buffer[headIndex].has_value()) ? buffer[headIndex].value() : std::nullopt;
    }
    
    std::optional<T> back() {
        int adjustedIndex = (tailIndex - 1 >= 0) ? tailIndex - 1 : capacity - 1;
        return (buffer[adjustedIndex].has_value()) ? buffer[adjustedIndex].value() : std::nullopt;
    }
    
    bool isEmpty() {
        return (count == 0);
    }
    
    bool isFull() {
        return (count == capacity);
    }
    
private:
    
    int capacity;
    int count;
    std::optional<T>* buffer;
    int headIndex;
    int tailIndex;
};

