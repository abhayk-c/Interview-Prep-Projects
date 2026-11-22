//
//  main.swift
//  List
//
//  Created by Abhay Curam on 7/7/26.
//

import Foundation

/**
 * LinkedList and Stack/Queue Tests
 */
var stringList = List<String>()
stringList.insertFront("Abhay")
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.insertFront("I'm")
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.insertFront("Hello")
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.removeFront()
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.removeFront()
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.removeFront()
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.removeFront()
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.insertBack("Hello")
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.insertBack("I'm")
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.insertBack("Abhay")
for str in stringList {
    print(str.value)
}
print(stringList.count)

print("Subscript Tests")
print(stringList[0]?.value)
print(stringList[1]?.value)
print(stringList[2]?.value)
print(stringList[3]?.value)


print("Remove tests")
stringList.removeBack()
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.removeBack()
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.removeBack()
for str in stringList {
    print(str.value)
}
print(stringList.count)

stringList.removeBack()
for str in stringList {
    print(str.value)
}
print(stringList.count)

print("Insert At Tests")
var integerList = List<Int>()
integerList.insertBack(1)
integerList.insertBack(3)
integerList.insertBack(4)
print("------------")
if let pos = integerList[1] {
    integerList.insertAt(2, pos)
}
for num in integerList {
    print(num.value)
}
print(integerList.count)
print("------------")
if let pos = integerList[0] {
    integerList.insertAt(0, pos)
}
for num in integerList {
    print(num.value)
}
print(integerList.count)
print("------------")
if let pos = integerList[4] {
    integerList.insertAt(3, pos)
}
for num in integerList {
    print(num.value)
}
print(integerList.count)
print("------------")
integerList.clear()
for num in integerList {
    print(num.value)
}
print(integerList.count)
print("-----------")
integerList.insertFront(2)
if let pos = integerList[0] {
    integerList.insertAt(1, pos)
}
for num in integerList {
    print(num.value)
}
print(integerList.count)


integerList.clear()
integerList.insertBack(1)
integerList.insertBack(2)
integerList.insertBack(3)
integerList.insertBack(4)
print("Remove At Tests")
if let pos = integerList[1] {
    integerList.removeAt(pos)
}
for num in integerList {
    print(num.value)
}
print(integerList.count)
print("-----------")
if let pos = integerList[0] {
    integerList.removeAt(pos)
}
for num in integerList {
    print(num.value)
}
print(integerList.count)
print("-----------")
if let pos = integerList[1] {
    integerList.removeAt(pos)
}
for num in integerList {
    print(num.value)
}
print(integerList.count)
print("-----------")
if let pos = integerList[0] {
    integerList.removeAt(pos)
}
for num in integerList {
    print(num.value)
}
print(integerList.count)


print("-------Leetcode Failing Test Case--------")
let myLinkedList = MyLinkedList()
myLinkedList.addAtHead(36)
myLinkedList.addAtHead(62)
myLinkedList.addAtTail(38)
myLinkedList.addAtHead(71)
print(myLinkedList.get(4))
myLinkedList.deleteAtIndex(2)
print(myLinkedList.get(2))
myLinkedList.deleteAtIndex(0)
myLinkedList.addAtHead(48)
print("--------------")
for num in myLinkedList.integerList {
    print(num.value)
}
print(myLinkedList.integerList.count)
myLinkedList.addAtIndex(3, 79)
print("--------------")
for num in myLinkedList.integerList {
    print(num.value)
}
print(myLinkedList.integerList.count)
myLinkedList.addAtIndex(3, 71)
print("--------------")
for num in myLinkedList.integerList {
    print(num.value)
}
print(myLinkedList.integerList.count)
myLinkedList.addAtHead(61)
myLinkedList.addAtTail(36)
myLinkedList.addAtHead(66)
myLinkedList.addAtTail(52)
myLinkedList.addAtTail(92)
myLinkedList.addAtTail(94)
myLinkedList.addAtTail(3)
print(myLinkedList.get(11))
print(myLinkedList.get(8))
myLinkedList.addAtHead(51)
myLinkedList.addAtTail(93)
myLinkedList.addAtIndex(5, 18)
myLinkedList.addAtHead(76)
print(myLinkedList.get(8))
myLinkedList.addAtHead(44)
myLinkedList.addAtTail(47)
myLinkedList.addAtTail(54)
myLinkedList.addAtHead(15)
myLinkedList.addAtHead(74)
print(myLinkedList.get(5))
myLinkedList.addAtHead(94)
myLinkedList.addAtTail(16)
myLinkedList.addAtHead(90)
print(myLinkedList.get(3))
myLinkedList.deleteAtIndex(2)
myLinkedList.addAtIndex(4, 59)
myLinkedList.addAtTail(25)
myLinkedList.deleteAtIndex(5)
myLinkedList.addAtTail(7)
myLinkedList.addAtHead(71)
myLinkedList.addAtTail(91)
myLinkedList.deleteAtIndex(24)
myLinkedList.addAtTail(70)
myLinkedList.addAtHead(61)
myLinkedList.addAtTail(58)
print(myLinkedList.get(22))
myLinkedList.addAtIndex(18, 81)
print(myLinkedList.get(9))
print(myLinkedList.get(2))
myLinkedList.addAtTail(50)
myLinkedList.addAtTail(12)
myLinkedList.deleteAtIndex(21)
myLinkedList.addAtTail(63)
myLinkedList.addAtIndex(28, 82)
myLinkedList.addAtTail(58)
myLinkedList.addAtHead(96)
myLinkedList.addAtTail(74)
myLinkedList.addAtTail(37)
myLinkedList.addAtTail(70)
myLinkedList.addAtHead(93)
myLinkedList.addAtHead(72)
myLinkedList.addAtHead(5)
print(myLinkedList.get(36))
myLinkedList.addAtTail(99)
myLinkedList.addAtIndex(9, 93)
myLinkedList.addAtIndex(1, 8)
myLinkedList.addAtIndex(29, 95)
myLinkedList.addAtIndex(5, 73)
myLinkedList.deleteAtIndex(20)
myLinkedList.deleteAtIndex(1)
myLinkedList.addAtIndex(2, 73)
myLinkedList.addAtIndex(34, 86)
myLinkedList.addAtTail(70)
myLinkedList.deleteAtIndex(47)
myLinkedList.addAtIndex(33, 13)
myLinkedList.addAtIndex(6, 99)
myLinkedList.addAtIndex(22, 11)
print(myLinkedList.get(50))
myLinkedList.addAtTail(55)
myLinkedList.addAtTail(92)
myLinkedList.deleteAtIndex(35)
myLinkedList.addAtHead(13)
print(myLinkedList.get(18))
myLinkedList.deleteAtIndex(0)
myLinkedList.addAtHead(78)
myLinkedList.addAtHead(43)
myLinkedList.addAtTail(2)
myLinkedList.addAtTail(58)
myLinkedList.addAtTail(96)
myLinkedList.addAtHead(23)
myLinkedList.addAtHead(93)
myLinkedList.addAtHead(6)
myLinkedList.addAtTail(90)
myLinkedList.addAtHead(97)
myLinkedList.addAtTail(53)
myLinkedList.addAtHead(7)
print(myLinkedList.get(43))
print(myLinkedList.get(33))
myLinkedList.addAtHead(95)
myLinkedList.deleteAtIndex(63)

print("---------------BST Tests---------------------")
print("\n")

/**
 * BinarySearchTree Tests
 */
print("------Printing standard balanced/fanned out tree-----")
let nodeK = TreeNode(key: "K", value: 9)
let nodeD = TreeNode(key: "D", value: 4, left: nodeK, right: nil)
let nodeG = TreeNode(key: "G", value: 10)
let nodeB = TreeNode(key: "B", value: 2, left: nodeG, right: nil)
let nodeZ = TreeNode(key: "Z", value: 4)
let nodeE = TreeNode(key: "E", value: 7, left: nil, right: nodeZ)
let nodeC = TreeNode(key: "C", value: 3, left: nodeD, right: nodeE)
let nodeA = TreeNode(key: "A", value: 1, left: nodeB, right: nodeC)
let bst = BinarySearchTree<String, Int>(root: nodeA)
print("Printing original tree:")
bst.printTree()
let bstCopy = bst.copy()
print("Printing copied tree:")
bstCopy.printTree()
print("Printing original tree after mutations: ")
nodeB.left = nil
nodeE.right = nil
nodeD.left = nil
bst.printTree()
print("Printing copied tree after mutations: ")
bstCopy.printTree()

print("------Printing single node and empty tests----------")
let singleNodeBST = BinarySearchTree<String, Int>(root: nodeK)
print("Printing original tree:")
singleNodeBST.printTree()
let singleNodeBSTCopy = singleNodeBST.copy()
print("Printing copied tree:")
singleNodeBSTCopy.printTree()
let emptyBST = BinarySearchTree<String, Int>(root: nil)
print("Printing original tree:")
emptyBST.printTree()
let emptyBSTCopy = emptyBST.copy()
print("Printing copied tree:")
emptyBSTCopy.printTree()

print("------Printing left skewed tree---------------------")
let nodeA0 = TreeNode(key: "A", value: 0)
let nodeB1 = TreeNode(key: "B", value: 1)
let nodeC2 = TreeNode(key: "C", value: 2)
let nodeD3 = TreeNode(key: "D", value: 3)
nodeA0.left = nodeB1
nodeB1.left = nodeC2
nodeC2.left = nodeD3
let leftSkewedTree = BinarySearchTree(root: nodeA0)
print("Printing original tree:")
leftSkewedTree.printTree()
let leftSkewedTreeCopy = leftSkewedTree.copy()
print("Printing copied tree:")
leftSkewedTreeCopy.printTree()

print("------Printing right skewed tree---------------------")
let nodeA9 = TreeNode(key: "A", value: 9)
let nodeB10 = TreeNode(key: "B", value: 10)
let nodeC11 = TreeNode(key: "C", value: 11)
let nodeD12 = TreeNode(key: "D", value: 12)
nodeA9.left = nodeB10
nodeB10.left = nodeC11
nodeC11.left = nodeD12
let rightSkewedTree = BinarySearchTree(root: nodeA9)
print("Printing original tree:")
rightSkewedTree.printTree()
let rightSkewedTreeCopy = rightSkewedTree.copy()
print("Printing copied tree:")
rightSkewedTreeCopy.printTree()

print("---------Tree Deep Copying with NSCopying Tests-------------------")
var numeroUno = NSNumber(integerLiteral: 1)
var numeroDos = NSNumber(integerLiteral: 2)
var numeroTres = NSNumber(integerLiteral: 3)
var numeroCuatro = NSNumber(integerLiteral: 4)
var numeroSiete = NSNumber(integerLiteral: 7)
var numeroNuevo = NSNumber(integerLiteral: 9)
var numeroDiez = NSNumber(integerLiteral: 10)
let nodeK_ = TreeNode(key: "K", value: numeroNuevo)
let nodeD_ = TreeNode(key: "D", value: numeroCuatro, left: nodeK_, right: nil)
let nodeG_ = TreeNode(key: "G", value: numeroDiez)
let nodeB_ = TreeNode(key: "B", value: numeroDos, left: nodeG_, right: nil)
let nodeZ_ = TreeNode(key: "Z", value: numeroCuatro)
let nodeE_ = TreeNode(key: "E", value: numeroSiete, left: nil, right: nodeZ_)
let nodeC_ = TreeNode(key: "C", value: numeroTres, left: nodeD_, right: nodeE_)
let nodeA_ = TreeNode(key: "A", value: numeroUno, left: nodeB_, right: nodeC_)
let bst_ = BinarySearchTree(root: nodeA_)
print("Printing original tree:")
bst_.printTree()
let bstCopy_ = bst_.copy()
print("Printing copied tree:")
bstCopy_.printTree()
numeroCuatro = NSNumber(integerLiteral: 100)
print("Printing original tree after value mutations: ")
bst_.printTree()
print("Printing copied tree after value mutations: ")
bstCopy_.printTree()

print("---------Tree Deep Copying without NSCopying Tests-------------------")
class IntegerBox: CustomStringConvertible {
    let intValue: Int
    var description: String {
        "\(intValue)"
    }
    init(intValue: Int) {
        self.intValue = intValue
    }
}

var numeroUnoBox = IntegerBox(intValue: 1)
var numeroDosBox = IntegerBox(intValue: 2)
var numeroTresBox = IntegerBox(intValue: 3)
var numeroCuatroBox = IntegerBox(intValue: 4)
var numeroSieteBox = IntegerBox(intValue: 7)
var numeroNuevoBox = IntegerBox(intValue: 9)
var numeroDiezBox = IntegerBox(intValue: 10)
let nodeK__ = TreeNode(key: "K", value: numeroNuevoBox)
let nodeD__ = TreeNode(key: "D", value: numeroCuatroBox, left: nodeK__, right: nil)
let nodeG__ = TreeNode(key: "G", value: numeroDiezBox)
let nodeB__ = TreeNode(key: "B", value: numeroDosBox, left: nodeG__, right: nil)
let nodeZ__ = TreeNode(key: "Z", value: numeroCuatroBox)
let nodeE__ = TreeNode(key: "E", value: numeroSieteBox, left: nil, right: nodeZ__)
let nodeC__ = TreeNode(key: "C", value: numeroTresBox, left: nodeD__, right: nodeE__)
let nodeA__ = TreeNode(key: "A", value: numeroUnoBox, left: nodeB__, right: nodeC__)
let bst__ = BinarySearchTree(root: nodeA__)
print("Printing original tree:")
bst__.printTree()
let bstCopy__ = bst__.copy()
print("Printing copied tree:")
bstCopy__.printTree()
numeroCuatroBox = IntegerBox(intValue: 100)
print("Printing original tree after value mutations: ")
bst__.printTree()
print("Printing copied tree after value mutations: ")
bstCopy__.printTree()

print("---------insertValueForKey and getValueForKey() tests---------------")
print("Reading and writing keys when tree is empty, Tree Empty tests")
let binarySearchTree = BinarySearchTree<Int, String>(root: nil)
print(binarySearchTree.getValueForKey(5) ?? "nil")
print(binarySearchTree.getAllKeysAndValues())
binarySearchTree.printTree()
print("Reading and writing keys when tree is empty, Tree Init tests")
binarySearchTree.insertKeyAndValue(5, "abhay")
print(binarySearchTree.getValueForKey(5) ?? "nil")
print(binarySearchTree.getAllKeysAndValues())
binarySearchTree.printTree()
print("Reading and writing keys, Right Skewed Tree. BST property verification and tree building Test.")
binarySearchTree.insertKeyAndValue(10, "ajay")
binarySearchTree.insertKeyAndValue(6, "mom")
print(binarySearchTree.getValueForKey(10) ?? "nil")
print(binarySearchTree.getValueForKey(6) ?? "nil")
print(binarySearchTree.getAllKeysAndValues())
binarySearchTree.printTree()
print("Reading and writing keys, Balanced slightly left-skewed Tree. BST property verification and tree building Test.")
binarySearchTree.insertKeyAndValue(3, "krishna")
binarySearchTree.insertKeyAndValue(4, "nakul")
binarySearchTree.insertKeyAndValue(1, "arjun")
binarySearchTree.insertKeyAndValue(0, "meera")
print(binarySearchTree.getValueForKey(4) ?? "nil")
print(binarySearchTree.getValueForKey(1) ?? "nil")
print(binarySearchTree.getValueForKey(0) ?? "nil")
print(binarySearchTree.getValueForKey(3) ?? "nil")
print(binarySearchTree.getAllKeysAndValues())
binarySearchTree.printTree()
print("Reading non-existent key test")
print(binarySearchTree.getValueForKey(2) ?? "nil")
print(binarySearchTree.getValueForKey(7) ?? "nil")
print("Upsertion tests")
binarySearchTree.insertKeyAndValue(5, "patty")
binarySearchTree.insertKeyAndValue(6, "pads")
binarySearchTree.insertKeyAndValue(0, "meeri")
print(binarySearchTree.getValueForKey(5) ?? "nil")
print(binarySearchTree.getValueForKey(6) ?? "nil")
print(binarySearchTree.getValueForKey(0) ?? "nil")
print(binarySearchTree.getAllKeysAndValues())
binarySearchTree.printTree()

print("---------removeKeyAndValue() tests---------------")
print("!!Removing a node with a non-nil right subtree (inOrder Successor Tests):!!")
let node4_6 = TreeNode<Double, String>(key: 4.6, value: "ajay")
let node4_5 = TreeNode<Double, String>(key: 4.5, value: "abhay", left: nil, right: node4_6)
let node4 = TreeNode<Double, String>(key: 4, value: "ching", left: nil, right: node4_5)
let node0 = TreeNode<Double, String>(key: 0, value: "nobody")
let node2 = TreeNode<Double, String>(key: 2, value: "DK", left: node0, right: node4)
let node5_5 = TreeNode<Double, String>(key: 5.5, value: "Bizzler", left: nil, right: nil)
let node6 = TreeNode<Double, String>(key: 6, value: "akash", left: node5_5, right: nil)
let node11 = TreeNode<Double, String>(key: 11, value: "madhavi")
let node8 = TreeNode<Double, String>(key: 8, value: "mikey", left: node6, right: node11)
let node5 = TreeNode(key: 5, value: "padma", left: node2, right: node8)
let BST = BinarySearchTree(root: node5)
print("Before Removal:")
BST.printTree()
print(BST.getAllKeysAndValues())
print("After Removal:")
BST.removeKeyAndValue(2)
BST.printTree()
print(BST.getAllKeysAndValues())
print("After Removing Root:")
BST.removeKeyAndValue(5)
BST.printTree()
print(BST.getAllKeysAndValues())
print("Restore Tree add a few more nodes:")
let node5_9 = TreeNode<Double, String>(key: 5.9, value: "Valhalla", left: nil, right: nil)
let node5_7 = TreeNode<Double, String>(key: 5.7, value: "Tsizai", left: nil, right: node5_9)
node6.left = node5_7
BST.printTree()
print(BST.getAllKeysAndValues())
print("After Removal:")
BST.removeKeyAndValue(5.5)
BST.printTree()
print(BST.getAllKeysAndValues())
BST.removeKeyAndValue(11)
BST.printTree()
print(BST.getAllKeysAndValues())
print()
print("!!Removing node NOT in tree:!!")
BST.removeKeyAndValue(11)
BST.printTree()
print(BST.getAllKeysAndValues())
print()
print("!!Removing LEAF Nodes:!!")
BST.removeKeyAndValue(4.6)
BST.removeKeyAndValue(5.9)
BST.printTree()
print(BST.getAllKeysAndValues())
print()
print("!!Removing nodes with ONLY left subtrees:!!")
BST.removeKeyAndValue(4)
BST.printTree()
print(BST.getAllKeysAndValues())
BST.removeKeyAndValue(4.5)
BST.printTree()
print(BST.getAllKeysAndValues())
BST.removeKeyAndValue(8)
BST.printTree()
print(BST.getAllKeysAndValues())
print()
print("!!Deleting tree with only one node left:!!")
BST.removeKeyAndValue(0)
BST.removeKeyAndValue(6)
BST.printTree()
print(BST.getAllKeysAndValues())
BST.removeKeyAndValue(5.7)
BST.printTree()
print(BST.getAllKeysAndValues())
print()
print("!!Deleting from empty tree no crash:!!")
BST.removeKeyAndValue(5.7)
BST.printTree()
print(BST.getAllKeysAndValues())
print()
print("!!Deleting root of tree with only left children:")
let leafNode = TreeNode(key: 2, value: "pads")
let midNode = TreeNode(key: 3, value: "abhay", left: leafNode, right: nil)
let root = TreeNode(key: 4, value: "ajay", left: midNode)
let leftBST = BinarySearchTree(root: root)
leftBST.printTree()
print(leftBST.getAllKeysAndValues())
leftBST.removeKeyAndValue(4)
leftBST.printTree()
print(leftBST.getAllKeysAndValues())
print()
print("!!Deleting root of tree with only right children:")
let leafNodeR = TreeNode(key: 6, value: "pads")
let midNodeR = TreeNode(key: 5, value: "abhay", left: nil, right: leafNodeR)
let rootR = TreeNode(key: 4, value: "ajay", left: nil, right: midNodeR)
let rightBST = BinarySearchTree(root: rootR)
rightBST.printTree()
print(rightBST.getAllKeysAndValues())
rightBST.removeKeyAndValue(4)
rightBST.printTree()
print(rightBST.getAllKeysAndValues())

print("---------BST Iterator tests---------------")
print("Iterating through empty tree test:")
var bstIteration = BinarySearchTree<Int, String>(root: nil)
var results = [BSTCursor<Int, String>]()
for element in bstIteration {
    results.append(element)
}
print(results)
print("Iterating through tree with single node tests:")
bstIteration.clear()
results = []
let singleNode = TreeNode(key: 0, value: "identityTest")
bstIteration.root = singleNode
for element in bstIteration {
    results.append(element)
}
print(results)
print("Iterating through tree left skewed tree tests:")
let fourNode = TreeNode(key: 4, value: "a")
let fiveNode = TreeNode(key: 5, value: "b", left: fourNode)
let sixNode = TreeNode(key: 6, value: "c", left: fiveNode)
let sevenNode = TreeNode(key: 7, value: "d", left: sixNode)
bstIteration.clear()
results = []
bstIteration.root = sevenNode
for element in bstIteration {
    results.append(element)
}
print(results)
print("Iterating through tree right skewed tree tests:")
let threeNode = TreeNode(key: 3, value: "c")
let twoNode = TreeNode(key: 2, value: "b", right: threeNode)
let oneNode = TreeNode(key: 1, value: "a", right: twoNode)
let zeroNode = TreeNode(key: 0, value: "?", right: oneNode)
bstIteration.clear()
results = []
bstIteration.root = zeroNode
for element in bstIteration {
    results.append(element)
}
print(results)
print("Iterating through complete balanced tree tests: ")
let balancedNode0 = TreeNode(key: 0, value: "a")
let balancedNode3 = TreeNode(key: 3, value: "c")
let balancedNode2 = TreeNode(key: 2, value: "b", left: balancedNode0, right: balancedNode3)
let balancedNode6 = TreeNode(key: 6, value: "e")
let balancedNode8 = TreeNode(key: 8, value: "g")
let balancedNode7 = TreeNode(key: 7, value: "f", left: balancedNode6, right: balancedNode8)
let balancedNode5 = TreeNode(key: 5, value: "d", left: balancedNode2, right: balancedNode7)
let balancedNode11 = TreeNode(key: 11, value: "i")
let balancedNode13 = TreeNode(key: 13, value: "k")
let balancedNode12 = TreeNode(key: 12, value: "j", left: balancedNode11, right: balancedNode13)
let balancedNode16 = TreeNode(key: 16, value: "m")
let balancedNode19 = TreeNode(key: 19, value: "o")
let balancedNode17 = TreeNode(key: 17, value: "n", left: balancedNode16, right: balancedNode19)
let balancedNode15 = TreeNode(key: 15, value: "l", left: balancedNode12, right: balancedNode17)
let balancedNode10 = TreeNode(key: 10, value: "h", left: balancedNode5, right: balancedNode15)
bstIteration.clear()
results = []
bstIteration.root = balancedNode10
for element in bstIteration {
    results.append(element)
}
print(results)

