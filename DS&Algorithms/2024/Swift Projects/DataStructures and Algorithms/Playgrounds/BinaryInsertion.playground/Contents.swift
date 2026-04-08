import UIKit

/**
 * An array class that leverages binary insertion algorithm
 * to always keep the array in sorted order.
 *
 * Runtime of each add operations is O(N) + O(log N)
 * This is also a way to implement a rudimentary BST using
 * just array's when u don't need a tree like structure but
 * just need data to be maintained in a sorted order and reasonably
 * fast enough writes/reads.
 */
public class SortedArray<T: Comparable>
{
    private var sortedData: [T] = []
    
    public var array: [T] {
        get {
            return sortedData
        }
    }
        
    public init() {}
    
    /**
     * I think you can blindly reuse your binary search algorithm but
     * just return a index. When your startIndex is no longer less than endIndex
     * blindly return that index value.
     * Check for boundary conditions and insert on either beginning or end of array if
     * boundary condition fails. Otherwise read the value in array at index. If value is
     * greater insert at left, otherwise insert at right. May need to "scan" for duplicates.
     */
    public func addElement(_ element: T) {
        let binaryIndex = retrieveIndexWithRecursiveBinarySearch(element)
        if binaryIndex < 0 {
            sortedData.insert(element, at: 0)
        } else if binaryIndex > sortedData.count - 1 {
            sortedData.append(element)
        } else {
            if sortedData[binaryIndex] > element {
                let insertionIndex = (binaryIndex < 0) ? 0 : binaryIndex
                sortedData.insert(element, at: insertionIndex)
            } else {
                let adjustedIndex = binaryIndex + 1
                let insertionIndex = (adjustedIndex > sortedData.count) ? (sortedData.count - 1) : adjustedIndex
                sortedData.insert(element, at: insertionIndex)
            }
        }
    }
    
    private func retrieveIndexWithIterativeBinarySearch(_ element: T) -> Int {
        var leftIndex = 0
        var rightIndex = sortedData.count - 1
        var currentIndex = 0
        while (leftIndex <= rightIndex) {
            let midIndex = leftIndex + ((rightIndex - leftIndex) / 2)
            if (sortedData[midIndex] == element) {
                currentIndex = midIndex
                break;
            }
            if (sortedData[midIndex] < element) {
                leftIndex = midIndex + 1
                currentIndex = leftIndex
            } else {
                rightIndex = midIndex - 1
                currentIndex = rightIndex
            }
        }
        
        return currentIndex
    }
    
    private func retrieveIndexWithRecursiveBinarySearch(_ element: T) -> Int {
        return retrieveIndexWithResursiveBinarySearchHelper(element, 0, sortedData.count - 1, 0)
    }
    
    private func retrieveIndexWithResursiveBinarySearchHelper(_ element: T, _ leftIndex: Int, _ rightIndex: Int, _ currentIndex: Int) -> Int
    {
        if (leftIndex > rightIndex) {
            return currentIndex
        }
        
        let midIndex = leftIndex + ((rightIndex - leftIndex) / 2)
        if (sortedData[midIndex] == element) {
            return midIndex
        }
        else if (sortedData[midIndex] < element) {
            return retrieveIndexWithResursiveBinarySearchHelper(element, midIndex + 1, rightIndex, midIndex + 1)
        } else {
            return retrieveIndexWithResursiveBinarySearchHelper(element, leftIndex, midIndex - 1, midIndex - 1)
        }
    }
}


let sortedArray = SortedArray<Int>()

sortedArray.addElement(3)
print(sortedArray.array)
sortedArray.addElement(2)
print(sortedArray.array)
sortedArray.addElement(1)
print(sortedArray.array)
sortedArray.addElement(6)
print(sortedArray.array)
sortedArray.addElement(6)
print(sortedArray.array)
sortedArray.addElement(6)
print(sortedArray.array)
sortedArray.addElement(6)
print(sortedArray.array)
sortedArray.addElement(4)
print(sortedArray.array)
sortedArray.addElement(7)
print(sortedArray.array)
sortedArray.addElement(9)
sortedArray.addElement(9)
sortedArray.addElement(9)
sortedArray.addElement(12)
sortedArray.addElement(12)
sortedArray.addElement(12)
sortedArray.addElement(-5)
sortedArray.addElement(-5)
sortedArray.addElement(-5)
print(sortedArray.array)

/*sortedArray.addElement(6)
print(sortedArray.array)
sortedArray.addElement(8)
print(sortedArray.array)
sortedArray.addElement(10)
print(sortedArray.array)
sortedArray.addElement(4)
print(sortedArray.array)
sortedArray.addElement(2)
print(sortedArray.array)
sortedArray.addElement(0)
print(sortedArray.array)
sortedArray.addElement(1)
print(sortedArray.array)
sortedArray.addElement(9)
print(sortedArray.array)
sortedArray.addElement(3)
print(sortedArray.array)
sortedArray.addElement(7)
print(sortedArray.array)
sortedArray.addElement(5)
print(sortedArray.array)*/




