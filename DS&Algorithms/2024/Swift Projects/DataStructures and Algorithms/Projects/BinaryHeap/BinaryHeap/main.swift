//
//  main.swift
//  BinaryHeap
//
//  Created by Abhay Curam on 8/2/24.
//

var minHeap = BinaryHeap<Int>(comparatorBlock: { (lhs, rhs) -> Bool in
    return lhs < rhs
})

minHeap.insert(3)
minHeap.insert(5)
minHeap.insert(7)
minHeap.insert(9)
print(minHeap.peek()!)
minHeap.printTree()

minHeap.insert(2)
print(minHeap.peek()!)
minHeap.printTree()

minHeap.insert(1)
print(minHeap.peek()!)
minHeap.printTree()

minHeap.insert(-1)
print(minHeap.peek()!)
minHeap.printTree()

minHeap.insert(0)
print(minHeap.peek()!)
minHeap.printTree()

minHeap.insert(10)
minHeap.insert(11)
minHeap.insert(12)
print(minHeap.peek()!)
minHeap.printTree()

minHeap.insert(6)
print(minHeap.peek()!)
minHeap.printTree()

minHeap.insert(-2)
print(minHeap.peek()!)
minHeap.printTree()


print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()

print(minHeap.pop())
print(minHeap.peek())
minHeap.printTree()
