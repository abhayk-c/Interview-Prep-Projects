import UIKit
import Foundation

/**
 * Using Swift Value Type arrays was the cleanest and fastest way to do this problem in Swift
 * but it definitely has issues with time complexity. These are some ideas to speed this up.
 *
 * 1. Use NSArray's, because these are dynamic arrays but handled as references the push(),
 * pop(), and top() API's should amortize at O(1). That being said popAtIndex() is still
 * poor time complexity.
 *
 * 2. If we want an even more optimal solution that can optimize the performance of popAtIndex()
 * maintain a linkedList of stacks like such in C++: List<Stack<T> *> stackList....
 * With this we can drop the time complexity of popAtIndex to the time it takes to iterate to the
 * index position (becomes O(N) where N is number of substacks). We can even make this faster if
 * we maintain a map of index to each subStack position in the list. Think a unordered_map that
 * associates the index to the iterator... something like unordered_map<int, ListIterator>. Could
 * improve to O(1) performance.
 *
 */
public class BoundedStacks<T: Any> {
    
    private var stacks: [[T]]
    private var stackCapacity: Int
    
    public init(capacity: UInt) {
        self.stacks = []
        self.stackCapacity = Int(capacity)
    }
    
    /**
     *
     * O(C) since accessing the current stack requires us
     * to copy the data since arrays are value types.
     *
     * That being said accessing the last subStack array and last element within
     * that array should be amortized O(1)
     */
    public func push(_ element: T) -> Void {
        guard let currentStack = stacks.last,
              currentStack.count < stackCapacity else {
            var newStack: [T] = []
            newStack.reserveCapacity(stackCapacity)
            newStack.append(element)
            stacks.append(newStack)
            return
        }
        var mutableCurrentStack = currentStack
        mutableCurrentStack.append(element)
    }
    
    /**
     * O(C), same reason as above
     */
    public func pop() -> T? {
        guard let currentStack = stacks.last else { return nil }
        var mutableCurrentStack = currentStack
        return mutableCurrentStack.popLast()
    }
    
    /**
     * O(C*N) where C is the capacity of a sub-stack and N is
     * all the stacks in our stack array. This operation is clearly the worst
     * because if you delete a subStack when it becomes empty at a index other than
     * the end the entire contents of the array and all data in their sub-stacks need
     * to get copied and moved over.
     */
    public func popAtIndex(_ index: UInt) -> T? {
        guard index < stacks.count else { return nil }
        var subStack: [T] = stacks[Int(index)]
        let result = subStack.popLast()
        if subStack.count == 0 {
            stacks.remove(at: Int(index))
        }
        return result
    }
        
    /**
     *
     * Time Complexity: O(C) where C is capacity or number of elements in stack
     */
    public func top() -> T? {
        return stacks.last?.last
    }
 
}
