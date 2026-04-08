//
//  List.hpp
//  ListStacksQueues
//
//  Created by Abhay Curam on 7/4/24.
//

#include <vector>
#include <optional>
#include <iterator>
#include "Deque.hpp"
#include "Stack.hpp"
#include "Queue.hpp"
using namespace std;

template <typename T> class List;

/**
 * MARK - Queue, Deque, Stack Creation convenience functions.
 * These make it so client's only get access to the API's of the interface
 * of the data structure that's being created. It's a way for the caller to work
 * with a Stack for example without needing to know the concrete internals of how
 * the Stack is implemented or having to instantiate a List just to use a Stack.
 *
 * Ofcourse the caller can simply instantiate a List and use that for any of these
 * data structure use cases. The caller must manager the memory of the returned pointer.
 */

/**
 * Using generics for a function in C++
 */
template <typename T> Queue<T> *CreateQueue(void) { return new List<T>(); }
template <typename T> Deque<T> *CreateDeque(void) { return new List<T>(); }
template <typename T> Stack<T> *CreateStack(void) { return new List<T>(); }


/**
 * MARK - List Implementation.
 * I put the entire List implementation in the Header just to speed up the implementation.
 * If this were real code I would split across header and .cpp file.
 */
template <typename T>
struct ListNode {
private:
    T data;
    ListNode *next = NULL;
    ListNode *prev = NULL;
    
public:
    ListNode(T data) : data{data} {}
    friend class List<T>;
};

template <typename T>
class List: public Deque<T>, public Stack<T>, public Queue<T> {
    
private:
    ListNode<T> *head = NULL;
    ListNode<T> *tail = NULL;
    
    /**
     * Mark - Iterator
     */
    struct iterator {
        friend class List<T>;
        using Category = forward_iterator_tag;
        using Distance = ptrdiff_t;
        
        iterator(ListNode<T> *ptr) : mPtr{ptr} {}
        
        T operator*() const {
            return mPtr->data;
        }
        
        T* operator->() {
            return &(mPtr->data);
        }
        
        bool operator==(const iterator& b)
        {
            return this->mPtr == b.mPtr;
        }
        
        bool operator!=(const iterator& b)
        {
            return this->mPtr != b.mPtr;
        }
        
        iterator operator++(int) {
            if (mPtr != NULL) {
                mPtr = mPtr->next;
            }
            return (*this);
        }
        
        iterator operator--(int) {
            if (mPtr != NULL) {
                mPtr = mPtr->prev;
            }
            return (*this);
        }
        
        private:
            ListNode<T> *mPtr;
    };
    
public:
    int count;
    
    /**
     * Mark - Constructors and Destructors
     */
    List(vector<T>& elements) {
        ListNode<T> *curNode = head;
        for (int i = 0; i < elements.size(); i++) {
            ListNode<T> *newNode = new ListNode(elements[i]);
            newNode->prev = curNode;
            if (curNode != NULL) {
                curNode->next = newNode;
            }
            curNode = newNode;
            //set head and tail pointers.
            if (i == 0) { head = curNode; }
            if (i == elements.size() - 1) { tail = curNode; }
            count += 1;
        }
    }
    
    List() {}
    
    ~List() {
        clear();
    }
    
    /**
     * Mark - List specific API
     */
    iterator begin() {
        return iterator(head);
    }
    
    iterator end() {
        return (tail != NULL) ? iterator(tail->next) : iterator(tail);
    }
    
    /**
     * This is a complete HACK and not how you are supposed to implement reverse
     * iteration in C++, but for speed of debugging my list I am just reusing
     * my existing forward iterator struct and operator overloading --() to
     * enumerate the list in reverse order.
     */
    iterator rend() {
        return iterator(tail);
    }
    
    iterator rbegin() {
        return (head != NULL) ? iterator(head->prev) : iterator(head);
    }
    
    void clear() {
        ListNode<T> *curNode = head;
        while (curNode != NULL) {
            ListNode<T> *nextNode = curNode->next;
            delete curNode;
            curNode = nextNode;
        }
        head = NULL;
        tail = NULL;
        count = 0;
    }
    
    /**
     * Removes the element at the supplied iterator position if it exists.
     */
    void removeAt(iterator& pos) {
        if (pos != end()) {
            ListNode<T> *curNode = pos.mPtr;
            ListNode<T> *prevNode = curNode->prev;
            ListNode<T> *nextNode = curNode->next;
            if (prevNode != NULL) {
                prevNode->next = nextNode;
            }
            if (nextNode != NULL) {
                nextNode->prev = prevNode;
            }
            delete curNode;
            count -= 1;
            /**
             * Set head and tail pointers properly
             */
            if (prevNode == NULL) { head = nextNode; }
            if (nextNode == NULL) { tail = prevNode; }
        }
    }
    
    /**
     * Inserts an element at the supplied iterator position.
     * Inserts the element, and pushes all the nodes back a position.
     * Inserting "2" at iterator position for element 3 in the list "{1, 3, 4}"
     * results in: "{1, 2, 3, 4}"
     */
    void insertAt(iterator& pos, T data) {
        if (pos == end()) {
            insertBack(data);
        } else {
            ListNode<T> *newNode = new ListNode<T>(data);
            ListNode<T> *nextNode = pos.mPtr;
            ListNode<T> *prevNode = nextNode->prev;
            newNode->next = nextNode;
            nextNode->prev = newNode;
            newNode->prev = prevNode;
            if (prevNode != NULL) { prevNode->next = newNode; }
            count += 1;
            /**
             * Handle head pointer, tail pointer is taken care of by insertBack()
             */
            if (prevNode == NULL) { head = newNode; }
        }
    }
    
    /**
     * Mark: - Deque API's
     */
    optional<T> front() {
        return (head != NULL) ? optional<T>(head->data) : nullopt;
    }
    
    optional<T> back() {
        return (tail != NULL) ? optional<T>(tail->data) : nullopt;
    }
    
    optional<T> popFront() {
        if (head != NULL) {
            ListNode<T> *nextNode = head->next;
            T result = head->data;
            delete head;
            head = nextNode;
            if (head != NULL) {
                head->prev = NULL;
            } else {
                tail = NULL;
            }
            count -= 1;
            return result;
        }
        
        return nullopt;
    }
    
    optional<T> popBack() {
        if (tail != NULL) {
            ListNode<T> *nextNode = tail->prev;
            T result = tail->data;
            delete tail;
            tail = nextNode;
            if (tail != NULL) {
                tail->next = NULL;
            } else {
                head = NULL;
            }
            count -= 1;
            return result;
        }
        
        return nullopt;
    }
    
    void insertFront(T data) {
        ListNode<T> *newNode = new ListNode(data);
        if (head != NULL) {
            newNode->next = head;
            head->prev = newNode;
        } else {
            tail = newNode;
        }
        head = newNode;
        count += 1;
    }
    
    void insertBack(T data) {
        ListNode<T> *newNode = new ListNode(data);
        if (tail != NULL) {
            newNode->prev = tail;
            tail->next = newNode;
        } else {
            head = newNode;
        }
        tail = newNode;
        count += 1;
    }
    
    /**
     * Stack API
     */
    optional<T> top() {
        return back();
    }
    
    void push(T data) {
        insertBack(data);
    }
    
    optional<T> pop() {
        return popBack();
    }
    
    /**
     * Queue API
     */
    virtual void enqueue(T data) {
        insertBack(data);
    }
    
    virtual optional<T> dequeue() {
        return popFront();
    }
    
};
