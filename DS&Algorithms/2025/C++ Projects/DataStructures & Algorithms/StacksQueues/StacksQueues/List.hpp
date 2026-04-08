//
//  List.hpp
//  List
//
//  Created by Abhay Curam on 4/24/25.
//

#include <iterator>
#include <cstddef>
#include <optional>

template <typename T>
struct ListNode {
    T data;
    ListNode* next;
    ListNode* prev;
    ListNode() : data(), next(nullptr), prev(nullptr) {}
    ListNode(const T& data) : data(data), next(nullptr), prev(nullptr) {}
};

template <typename T>
class List {
    
public:
    
    /**
     * A custom iterator object for the List
     */
    struct ListIterator {
    public:
        enum Direction { forward, reverse };
        using iterator_category = std::bidirectional_iterator_tag;
        using difference_type   = ptrdiff_t;
        
        ListIterator(ListNode<T>* list_ptr, Direction iterator_direction) : list_ptr(list_ptr), iterator_direction(iterator_direction) {}
        
        ListNode<T>& operator*() const {
            /*
             * This can also simply return a (list_ptr->data) and many interators
             * are designed this way to make it feel like dereferencing an iterator
             * feels like dereferencing a raw pointer. It depends on your implementation
             */
            return (*list_ptr);
        }
        
        ListNode<T>* operator->() {
            return list_ptr;
        }
        
        ListIterator& operator++(int) {
            if (list_ptr != nullptr) {
                list_ptr = list_ptr->next;
            }
            iterator_direction = forward;
            return (*this);
        }
        
        ListIterator& operator--(int) {
            if (list_ptr != nullptr) {
                list_ptr = list_ptr->prev;
            }
            iterator_direction = reverse;
            return (*this);
        }
        
        bool operator==(const ListIterator& rhs) const {
            return this->list_ptr == rhs.list_ptr;
        }
        
        bool operator!=(const ListIterator& rhs) const {
            return this->list_ptr != rhs.list_ptr;
        }
        
    private:
        friend class List<T>;
        ListNode<T>* list_ptr;
        Direction iterator_direction;
    };
    
    /**
     * Constructors and Destructors
     */
    
    /**
     * Custom constructor using member wise initialization
     */
    List() : head(nullptr), tail(nullptr), count(0) {}
    
    List(const List& rhs) : head(nullptr), tail(nullptr), count(0)
    {
        copyList(rhs);
    }
    
    List& operator=(const List& rhs)
    {
        if (this != &rhs) {
            // first clear any existing data in current list
            clear();
            // now we perform a deep copy
            copyList(rhs);
        }
        return (*this);
    }
    
    ~List()
    {
        clear();
    }
     
    /**
     * Public List API's
     */
    const int& size()
    {
        return count;
    }
    
    std::optional<T> front()
    {
        return (head != nullptr) ? std::optional<T>(head->data) : std::nullopt;
    }
    
    std::optional<T> back()
    {
        return (tail != nullptr) ? std::optional<T>(tail->data) : std::nullopt;
    }
    
    ListIterator begin() {
        return ListIterator(head, ListIterator::forward);
    }
    
    ListIterator end() {
        return (tail != nullptr) ? ListIterator(tail->next, ListIterator::forward) : ListIterator(tail, ListIterator::forward);
    }
    
    ListIterator rbegin() {
        return ListIterator(tail, ListIterator::reverse);
    }
    
    ListIterator rend() {
        return (head != nullptr) ? ListIterator(head->prev, ListIterator::reverse) : ListIterator(head, ListIterator::reverse);
    }
    
    void insertFront(const T& value)
    {
        if (head == nullptr) {
            ListNode<T>* node = new ListNode<T>(value);
            head = node;
            tail = node;
        } else {
            ListNode<T>* node = new ListNode<T>(value);
            node->next = head;
            head->prev = node;
            head = node;
        }
        count++;
    }
    
    void removeFront()
    {
        if (head != nullptr) {
            ListNode<T>* temp = head;
            head = head->next;
            if (head == nullptr) {
                tail = nullptr;
            } else {
                head->prev = nullptr;
            }
            delete temp;
            count--;
        }
    }
    
    void insertBack(const T& value)
    {
        if (tail == nullptr) {
            ListNode<T>* node = new ListNode<T>(value);
            tail = node;
            head = node;
        } else {
            ListNode<T>* node = new ListNode<T>(value);
            tail->next = node;
            node->prev = tail;
            tail = node;
        }
        count++;
    }
    
    void removeBack()
    {
        if (tail != nullptr) {
            ListNode<T>* temp = tail;
            tail = tail->prev;
            if (tail == nullptr) {
                head = nullptr;
            } else {
                tail->next = nullptr;
            }
            delete temp;
            count--;
        }
    }
    
    void clear()
    {
        ListNode<T>* temp = head;
        while (temp != nullptr) {
            ListNode<T>* next = temp->next;
            delete temp;
            temp = next;
        }
        head = nullptr;
        tail = nullptr;
        count = 0;
    }
    
    void insertAt(const ListIterator& pos, const T& value)
    {
        if (pos == begin()) {
            insertFront(value);
        } else if (pos == end() && pos.iterator_direction == ListIterator::forward) {
            insertBack(value);
        } else {
            ListNode<T>* curr = &(*pos);
            if (curr != nullptr && curr->prev != nullptr) {
                ListNode<T> *temp = curr->prev;
                ListNode<T> *node = new ListNode<T>(value);
                temp->next = node;
                node->prev = temp;
                node->next = curr;
                curr->prev = node;
                count++;
            }
        }
    }
    
    /**
     * A cleaner API next time would be to return a new ListIterator
     * here instead of void to be more in-line with STL container design.
     * Why? Because the current pointer the Iterator is pointing to gets
     * invalidated/deleted. Giving a new iterator to the client pointing
     * to the "next" valid position in the list would be cleaner.
     */
    void removeAt(const ListIterator& pos)
    {
        if (pos != end()) {
            ListNode<T>* curr = &(*pos);
            if (curr->prev != nullptr) {
                curr->prev->next = curr->next;
            } else {
                //advance head pointer
                //Should also properly set to null when last element in list
                head = curr->next;
            }
            if (curr->next != nullptr) {
                curr->next->prev = curr->prev;
            } else {
                //advance tail pointer
                //Should also properly set to null when last element in list
                tail = curr->prev;
            }
            delete curr;
            count--;
        }
    }
    
private:
    
    ListNode<T>* head;
    ListNode<T>* tail;
    int count;
    
    void copyList(const List& from)
    {
        ListNode<T>* source = from.head;
        while (source != nullptr) {
            insertBack(source->data);
            source = source->next;
        }
    }
    
};

