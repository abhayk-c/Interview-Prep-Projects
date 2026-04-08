//
//  Vector.hpp
//  Vector
//
//  Created by Abhay Curam on 5/12/25.
//

#include <exception>
#include <string>

/**
 * This vector implementation leverages new[] and delete[] for
 * memory allocation on the heap which is okay but has the following problems:
 *
 * 1. new[] not only allocates a block of memory but initializes the memory which
 *    means a default constructor is called and required for type T. If a type T
 *    defines its own constructor then this won't compile since that removes the default
 *    constructor in C++. This makes this API quite restrictive since many types
 *    define their own constructors.
 *
 * 2. Allocation is cheap but element construction/initialization can be expensive.
 *    Its better to defer construction to when its actually needed (pushing back an element).
 *
 * A better approach is to separate allocation and initialization. Simply allocate the memory
 * and then construct/initialize the object in real time when adding it. The construction will
 * be done by invoking the copy constructor or copy on assignment. This approach makes the
 * implementation more efficient, and also the API less restrictive. We can make it so
 * type T need only define a copy constructor, T is free to not have a default constructor
 * allowing the clients to define whatever constructors for type T they need. This is actually
 * pretty much what std::vector container in STL does.
 *
 * To implement this one needs to use std::allocator to allocate raw memory and "placement new"
 * technique to construct element in place at a specific mem address. Honestly its not
 * rocket science just research this if you need. To specify type T must have a copy constructor
 * can use template "traits" from C++20 standard.
 *
 */
template <typename T>
class Vector
{

public:
    Vector() : storage(nullptr), size(0), capacity(0) {}
    Vector(int capacity) : storage(new T[capacity]), size(0), capacity(capacity) {}
    
    ~Vector()
    {
        reset();
    }
    
    Vector(const Vector& rhs)
    {
        copyVector(rhs);
    }
    
    Vector& operator=(const Vector& rhs)
    {
        if (this != &rhs) {
            reset();
            copyVector(rhs);
        }
        return *this;
    }
    
    /**
     * Example of overloading the subscript operator, this works for both
     * reading and assignment because the overloaded operator returns a reference
     * so to write you just set the reference to a new value.
     * The reference memory scope should outlive the function. In this case
     * the reference lives in heap memory.
     */
    T& operator[](int index) const
    {
        if (index >= 0 && index < size) {
            return storage[index];
        }
        throw std::out_of_range("The index provided was out of range, please provide a valid index.");
    }
    
    const T& front() const
    {
        if (!empty()) {
            return storage[0];
        }
        throw std::out_of_range("The array is empty.");
    }
    
    const T& back() const
    {
        if (!empty()) {
            return storage[size-1];
        }
        throw std::out_of_range("The array is empty.");
    }
    
    void push_back(const T& value)
    {
        if (size == capacity) {
            resizeStorage();
        }
        // Even though we pass by reference the [] operator
        // and assignment forces the reference to be copied.
        storage[size] = value;
        size++;
    }
    
    void pop_back()
    {
        if (!empty()) {
            size--;
        }
    }
    
    void insertAt(const int& index, const T& value)
    {
        if (index >= 0 && index <= size) {
            if (size == capacity) {
                resizeStorage();
            }
            T x, y;
            x = value;
            for (int i = index; i <= size; i++) {
                y = storage[i];
                storage[i] = x;
                x = y;
            }
            size++;
        } else {
            throw std::out_of_range("The index provided was out of range, please provide a valid index.");
        }
    }
    
    void removeAt(const int& index)
    {
        if (index >= 0 && index < size) {
            if (!empty()) {
                T x, y;
                x = storage[size - 1];
                for (int i = size - 2; i >= index; i--) {
                    y = storage[i];
                    storage[i] = x;
                    x = y;
                }
                size--;
            }
        } else {
            throw std::out_of_range("The index provided was out of range, please provide a valid index.");
        }
    }
    
    void reset()
    {
        size = 0;
        capacity = 0;
        delete[] storage;
    }
    
    /**
     * Number of elements in the vector, the logical size.
     * Not the same as capacity.
     */
    int getSize() const
    {
        return size;
    }
    
    /**
     * Capacity of the vector (buffer storage size).
     */
    int getCapacity() const
    {
        return capacity;
    }
    
    bool empty() const
    {
        return (size == 0);
    }
    
private:
    T* storage;
    int size;
    int capacity;
    
    void resizeStorage()
    {
        capacity = (capacity == 0) ? 1 : (capacity * 2);
        T* expandedStorage = new T[capacity];
        for (int i = 0; i < size; i++) {
            expandedStorage[i] = storage[i];
        }
        delete[] storage;
        storage = expandedStorage;
    }
    
    void copyVector(const Vector& from)
    {
        size = from.size;
        capacity = from.capacity;
        storage = new T[capacity];
        for (int i = 0; i < from.getSize(); i++) {
            storage[i] = from[i];
        }
    }
};
