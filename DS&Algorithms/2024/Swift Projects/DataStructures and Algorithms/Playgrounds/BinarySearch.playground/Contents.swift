import Foundation
import UIKit


func recursiveBinarySearchHelper<T: Comparable>(_ sortedArray: inout [T], _ k: T, _ leftIndex: Int, _ rightIndex: Int) -> T? {
    let midIndex = leftIndex + ((rightIndex - leftIndex) / 2)
    if (leftIndex > rightIndex) {
        return nil
    }
    
    if (sortedArray[midIndex] == k) {
        return sortedArray[midIndex]
    }
    else if (sortedArray[midIndex] < k) {
        return recursiveBinarySearchHelper(&sortedArray, k, midIndex + 1, rightIndex)
    } else {
        return recursiveBinarySearchHelper(&sortedArray, k, leftIndex, midIndex - 1)
    }
}

    
func recursiveBinarySearch<T: Comparable>(_ sortedArray: inout [T], _ k: T) -> T? {
    return recursiveBinarySearchHelper(&sortedArray, k, 0, sortedArray.count - 1)
}

func iterativeBinarySearch<T: Comparable>(_ sortedArray: inout [T], _ k: T) -> T? {
    var leftIndex = 0
    var rightIndex = sortedArray.count - 1
    while (leftIndex <= rightIndex) {
        let midIndex = leftIndex + ((rightIndex - leftIndex) / 2)
        if (sortedArray[midIndex] == k) {
            return sortedArray[midIndex]
        }
        if (sortedArray[midIndex] < k) {
            leftIndex = midIndex + 1
        } else {
            rightIndex = midIndex - 1
        }
    }
    
    return nil
}

var sortedArray = [1, 3, 5, 7]
let result = recursiveBinarySearch(&sortedArray, 8)
print(result)

//Declare array and iterate through it
var exampleArray = [-1, 2, 3, 4]
for element in exampleArray {
    print(element)
}

//Mutate the array
exampleArray[0] = 1
exampleArray.append(5)
exampleArray.insert(0, at: 0) //insert at front

//Accessing elements
print(exampleArray.first ?? "")
print(exampleArray.last ?? "")
print(exampleArray[0])


