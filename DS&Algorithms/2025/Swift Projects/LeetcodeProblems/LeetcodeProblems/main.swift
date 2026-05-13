//
//  main.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 5/20/25.
//

import Foundation


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}


/// Helper function to give more meaningful assertion results.
func assertEqual<T: Equatable>(actual: T, expected: T) {
   if actual != expected {
       print("FAILURE: Expected \(expected) but got \(actual)")
   } else {
       print("SUCCESS: Got \(actual) as expected")
   }
}


var board: [[Character]] =
[["5","3","2",".","4",".",".",".","."]
,["6",".",".","1","9","5",".",".","."]
,[".","9","7",".",".",".",".","6","."]
,["8",".",".",".","6",".",".",".","3"]
,["4",".",".","8",".","3",".",".","1"]
,["7",".",".",".","2",".",".",".","6"]
,[".","6",".",".",".",".","2","8","."]
,[".",".",".","4","1","9",".",".","."]
,[".",".",".",".","8",".",".","7","7"]]

print(isValidSudoku(board))

var elements = [3,2,5,1,2,4,0,7]
print(findMinAndMax(elements: &elements))


var testArray: [Int] = [1, 1, 1, 1, 1]
filterDuplicatesInPlace(&testArray)
print(testArray)

// Ceil, floor, and round functions only work on doubles and floats.
// You have to cast back to int if dealing with integers.
let pi: Double = 3.14
let theta: Float = 4.44
let x = ceil(pi)
let y: Int = Int(floor(theta))
let z = round(pi)
let k = round(theta)

let rangeOne = 0..<8 // [0, 8) -> inclusive of 0, exclusive of 8
let rangeTwo = 0...8 // [0, 8] -> inclusive of 0 and 8
let rangeThree = -5...(-1) // Negative ranges also work but u need parens
// All ranges are in ascending order, to create a descending range
// you have to reverse() it.
let descendingRange = rangeOne.reversed()

print(rangeOne.lowerBound) // "0", accessing min of range
print(rangeOne.upperBound) // "8", accessing max of range
for i in rangeOne { } // Iterate through all values in range.

var towerOne = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
var towerTwo: [Int] = []
var towerThree: [Int] = []
simulateTowersOfHanoi(&towerOne, &towerTwo, &towerThree)
print(towerOne)
print(towerTwo)
print(towerThree)

print(multiplyWithoutUsingMultiplicationOperator(x: 3, y: 5))
print(subsetsOfSizeK(5, 3))
print("\n")
print("Palindromic Partitions: ")
print(computePalindromeDecompositions("0204451881"))
print(computePalindromePartitions("0204451881"))

print("\n")
print("Knapsack Problem:")
let maxValue = maxValueForKnapsack(10, [11, 12, 13], [5, 6, 2])
print(maxValue)

print("\n")
print("Climbing Stairs with Memoization: ")
print(numWaysToClimbStairs(4, 2))
print("Climbing Stairs with Tabulation: ")
print(climbStairs(4, 2))

print("\n")
print("Compute ways to make change: ")
print(computeWaysToMakeChange(7, [1,2,5]))

print("\n")
print(uniquePaths(5, 2))
print(uniquePathsBottomUp(5, 2))
print("Computing Levenshtein Distance:")
print(computeWordDistance("dinitrophenylhydrazine", "acetylphenylhydrazine"))

print("Solving Board with Sorrounded Regions:")
var grid: [[Character]] = [["X", "X", "X", "X", "X"],
                           ["X", "X", "X", "X", "X"],
                           ["X", "X", "X", "X", "X"],
                           ["X", "X", "X", "X", "X"],
                           ["X", "X", "X", "X", "X"],
                           ["X", "X", "X", "X", "X"],
                           ["X", "X", "X", "X", "X"],
                           ["X", "X", "X", "X", "X"],
                           ["X", "X", "X", "X", "X"],
                           ["X", "X", "X", "X", "X"]]

solveSurroundedRegions(&grid)
for row in 0..<grid.count {
    print(grid[row])
}

print("Testing Transform Words Problem: ")
let wordSetOne: Set<String> = ["cat", "rat", "rot", "log", "bat", "cot", "dog", "dag", "dot"]
print(computeShortestWordProductionSequence("cat", "dag", wordSetOne))
let wordSetTwo: Set<String> = ["cat", "rat", "rot", "log", "bat", "dog", "dag", "dot"]
print(computeShortestWordProductionSequence("cat", "dag", wordSetTwo))
print(computeShortestWordProductionSequence("cat", "te", wordSetTwo))
let wordSetThree: Set<String> = ["cat", "rat", "rot", "log", "bat", "cot", "dog", "dag", "dot", "dat"]
print(computeShortestWordProductionSequence("cat", "dog", wordSetThree))
let wordSetFour: Set<String> = ["cat", "rat", "rot", "log", "bat", "cot", "dog", "dag", "dot", "dat"]
print(computeShortestWordProductionSequence("cat", "dog", wordSetFour))


let characterOne: Character = "1"
let integerOne: Int = characterOne.wholeNumberValue!

let integerTwo: Int = 2
let asciiValue = UnicodeScalar(integerTwo)
let characterTwo: Character = Character(asciiValue!)

print("")

let weightedStrings = ["hello" : 0.23, "world" : 0.5, "good day" : 0.27]
let randomStringGenerator = WeightedRandomStringGenerator(weightedStrings)
for i in 0..<20 {
    print(randomStringGenerator.generateRandomString())
}

print("")

let weightedSampler = WeightedRandomSampler([25,25,20,20,10])
for i in 0..<19 {
    print(weightedSampler.pickIndex())
}

print("")
let excelColumnValues = ExcelSheetColumnNumbers()
print(excelColumnValues.titleToNumber("A"))
print(excelColumnValues.titleToNumber("B"))
print(excelColumnValues.titleToNumber("Z"))
print(excelColumnValues.titleToNumber("AA"))
print(excelColumnValues.titleToNumber("AB"))
print(excelColumnValues.titleToNumber("BA"))
print(excelColumnValues.titleToNumber("ZY"))

print("")
let scrambledIntervalsOne: [[Int]] = [[2,6],[1,4],[15,18],[3,5],[8,10],[9,13]]
let scrambledIntervalsTwo: [[Int]] = [[2,6],[1,4],[9,13],[8,10],[3,5],[15,18]]
let discreetIntervals: [[Int]] = [[4,5],[1,3],[15,17],[6,8],[9,12]]
let singleMergedInterval: [[Int]] = [[3,5],[1,3],[14,18],[5,9],[9,17]]
let mergeIntervals = MergeOverlappingIntervals()
print(mergeIntervals.merge(scrambledIntervalsOne))
print(mergeIntervals.merge(scrambledIntervalsTwo))
print(mergeIntervals.merge(discreetIntervals))
print(mergeIntervals.merge(singleMergedInterval))

print("")
let binary = BinaryAdder()
print(binary.addBinary("1111", "1111"))
print(binary.addBinary("1001", "1101"))
print(binary.addBinary("1101", "11"))
print(binary.addBinary("10", "110"))

// Allows you to convert a string in binary to its int value.
let dummy: Int = Int("1010", radix: 2)!
print(dummy)

print("")
let longestSubStr = LongestRepeatingSubString()
print(longestSubStr.lengthOfLongestSubstring("abbabbabb"))
print(longestSubStr.lengthOfLongestSubstring("abcdefghijkolmnopqrstuvwxyz"))

//Absolute values
let g: Double = -13
let q = fabs(g) //Absolute value of a float or double

// Random Numbers

//Min and Max
print(min(3, 3.5))
print(max(2, 9))
print(min("A", "a")) //Works with any comparable type

// Log, exponent, sqrt functions.
let ab: Double = 8.0
let bc: Float = 24.93
let zy: Float = 9.9
print(log2(ab)) //Log only works with doubles and floats
print(log10(bc))
print(sqrt(zy)) //Sqrt only works with doubles and floats
let base: Decimal = 2.2
let exp: Int = 3
print(pow(base, exp)) // (2.2)^3
// pow() function only works with Decimal types as the base, and Ints for exponent.

print("Hexadecimal Tests: ")
let dummyInt = 106716
let hexConverter = HexadecimalConverter()
print(hexConverter.toHex(dummyInt))

print("Image Rotation Tests: ")
let matrixRotation = MatrixRotation()
var matrix = [[5,1,9,11],
              [2,4,8,10],
              [13,3,6,7],
              [15,14,12,16]]
print("before rotation: ")
print("after rotation: ")
matrixRotation.rotate(&matrix)


let wordsFormedByChars = WordsFormedByCharacters()
print(wordsFormedByChars.countCharacters(["cat","bt","hat","tree"], "atach"))
print(wordsFormedByChars.countCharacters(["hello","world","leetcode"], "welldonehoneyr"))
print(wordsFormedByChars.countCharacters(["gataca","bal","capab", "curr", "ab"], "ab"))
print(wordsFormedByChars.countCharacters(["gataca","bal","capab", "curr", "abb"], "ab"))
print(wordsFormedByChars.countCharacters(["gataca","bal","capab", "curr", "ab"], "welldonehoneyr"))


print("Testing Snake Game: ")
let snakeGame = SnakeGame(7, 6, [[0,2],[3,3]])
print("Positive Case, eating 2 foods: ")
print(snakeGame.move("R"))
print(snakeGame.move("R"))
print(snakeGame.move("D"))
print(snakeGame.move("D"))
print(snakeGame.move("D"))
print(snakeGame.move("R"))
print("Negative case, eating 4 foods and colliding with body: ")
let snakeGame2 = SnakeGame(7, 6, [[0,2],[3,3],[3,5],[3,6]])
print(snakeGame2.move("R"))
print(snakeGame2.move("R"))
print(snakeGame2.move("D"))
print(snakeGame2.move("D"))
print(snakeGame2.move("D"))
print(snakeGame2.move("R"))
print(snakeGame2.move("R"))
print(snakeGame2.move("R"))
print(snakeGame2.move("R"))
print(snakeGame2.move("D"))
print(snakeGame2.move("L"))
print(snakeGame2.move("U"))
print("Positive case eating 4 foods, testing boundary with tail:")
let snakeGame3 = SnakeGame(3, 3, [[2,0],[0,0],[0,2],[2,2]])
print(snakeGame3.move("D"))
print(snakeGame3.move("D"))
print(snakeGame3.move("R"))
print(snakeGame3.move("U"))
print(snakeGame3.move("U"))
print(snakeGame3.move("L"))
print(snakeGame3.move("D"))
print(snakeGame3.move("R"))
print(snakeGame3.move("R"))
print(snakeGame3.move("U"))
print(snakeGame3.move("L"))
print(snakeGame3.move("D"))

//[[10000,10000,[[0,1],[0,2],[0,3],[0,4],[1,4],[2,4],[2,3],[2,2],[2,1],[2,0],[1,0]]],["R"],["R"],["R"],["R"],["D"],["D"],["L"],["L"],["L"],["L"],["U"],["U"]]
let snakeGame4 = SnakeGame(10000,10000,[[0,1],[0,2],[0,3],[0,4],[1,4],[2,4],[2,3],[2,2],[2,1],[2,0],[1,0]])
print(snakeGame4.move("R"))
print(snakeGame4.move("R"))
print(snakeGame4.move("R"))
print(snakeGame4.move("R"))
print(snakeGame4.move("D"))
print(snakeGame4.move("D"))
print(snakeGame4.move("L"))
print(snakeGame4.move("L"))
print(snakeGame4.move("L"))
print(snakeGame4.move("L"))
print(snakeGame4.move("U"))
print(snakeGame4.move("U"))

print("Text Editor Undo Redo Tests: --------------------------------------")

let doc: TextDocument = TextDocument()
assertCurrentContent(doc, "") // should print ""

doc.applyOperation(.deleteFromEnd(numCharsToDelete: 10))
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "")
var content = doc.getCurrentContent()
print("Dumping document content: \(content)")

doc.applyOperation(.insertAtEnd(charsToInsert: "hello"))
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "hello")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

doc.applyOperation(.insertAtEnd(charsToInsert: "abhay"))
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "helloabhay")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

doc.applyOperation(.insertAtEnd(charsToInsert: "world"))
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "helloabhayworld")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

doc.applyOperation(.deleteFromEnd(numCharsToDelete: 5))
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "helloabhay")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

print("Undo Cases-----------------------------------------------")

doc.undoLast()
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "helloabhayworld")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

doc.undoLast()
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "helloabhay")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

doc.undoLast()
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "hello")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

print("Redo Cases-----------------------------------------------")

doc.redoLast()
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "helloabhay")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

doc.redoLast()
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "helloabhayworld")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

doc.redoLast()
print("Test case assert, if empty we are good: ")
assertCurrentContent(doc, "helloabhay")
content = doc.getCurrentContent()
print("Dumping document content: \(content)")

print("Testing WordSearch 2:-----------------------------")
let wordSearchBoard: [[Character]] = [["e","a","e"],
                                      ["e","a","e"],
                                      ["g","a","a"],
                                      ["r","n","m"]]
let wordSearch = WordSearch2()
print(wordSearch.findWords(wordSearchBoard, ["eaeeaeaagrnm", "eaeeaagrnm"]))


let wordSearchBoard2: [[Character]] = [["a","a"]]
let wordSearch2 = WordSearch2()
print(wordSearch2.findWords(wordSearchBoard2, ["aaa"]))


let wordSearchBoard3: [[Character]] = [["e","a","a","l"],
                                       ["a","n","a","l"],
                                       ["a","n","a","n"],
                                       ["n","e","e","a"]]
let wordSearch3 = WordSearch2()
print(wordSearch3.findWords(wordSearchBoard3, ["eaaan", "eaan"]))


let wordSearchBoard4: [[Character]] = [["a","a"],
                                       ["a","a"]]
let wordSearch4 = WordSearch2()
print(wordSearch4.findWords(wordSearchBoard4, ["aaaaa"]))


let wordSearchBoard5: [[Character]] = [["a","p","p"],
                                       ["p","p","l"],
                                       ["e","l","y"],
                                       ["c","i","e"],
                                       ["n","a","d"]]
let wordSearch5 = WordSearch2()
print(wordSearch5.findWords(wordSearchBoard5, ["appl","apple","apply","applied","appliance"]))

print("LinkedListCycleDetectorTests")
let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(3)
let node4 = ListNode(4)
let node5 = ListNode(5)
node1.next = node1
node2.next = node3
node3.next = node4
node4.next = node5
node5.next = nil
print(LinkedListCycleDetector().hasCycle(node1))

print("Draw monochrome screen tests")
var screen: [UInt8] = [0,0]
drawLine(&screen, 16, 7, 8, 0)
print(screen)

// DataStructure Traces Problem (DuoLingo)
assertEqual(actual: dataStructures([.insert(1), .insert(3), .insert(3), .insert(1)]), expected: [.queue, .priority, .stack])
assertEqual(actual: dataStructures([.insert(1), .insert(3), .insert(3), .insert(1), .pop(1)]), expected: [.queue, .priority, .stack])
assertEqual(actual: dataStructures([.insert(1), .insert(3), .insert(3), .insert(1), .pop(1), .pop(3)]), expected: [.queue, .stack])
assertEqual(actual: dataStructures([.insert(1), .insert(3), .insert(3), .insert(1), .pop(1), .pop(3), .pop(4)]), expected: [])
assertEqual(actual: dataStructures([.insert(1), .insert(3), .insert(3), .insert(1), .pop(1)]), expected: [.queue, .priority, .stack])
assertEqual(actual: dataStructures([.insert(1), .insert(3), .insert(3), .insert(1), .pop(1), .insert(4)]), expected: [.queue, .priority, .stack])
assertEqual(actual: dataStructures([.insert(1), .insert(3), .insert(3), .insert(1), .pop(1), .insert(4), .pop(4)]), expected: [.stack])
assertEqual(actual: dataStructures([.insert(1), .insert(3), .insert(3), .insert(1), .pop(1), .insert(4), .pop(1)]), expected: [.priority])

let trace = [Action.insert(5), .insert(10), .pop(5)]
   assertEqual(actual: dataStructures(trace), expected: [DataStructure.queue, .priority])
   assertEqual(actual: dataStructures([]), expected: [DataStructure.stack, .queue, .priority])
   assertEqual(actual: dataStructures([.pop(5)]), expected: [])
   assertEqual(actual: dataStructures([.insert(5)]), expected: [.stack, .queue, .priority])
   assertEqual(actual: dataStructures([.insert(5), .insert(2)]), expected: [.stack, .queue, .priority])
   assertEqual(actual: dataStructures([.insert(5), .pop(5)]), expected: [.stack, .queue, .priority])
   assertEqual(actual: dataStructures([.insert(5), .pop(5), .pop(5)]), expected: [])
   assertEqual(actual: dataStructures([.insert(5), .pop(5), .insert(0), .pop(0)]), expected: [.stack, .queue, .priority])
   assertEqual(actual: dataStructures([.insert(3), .insert(4), .insert(2), .pop(2), .pop(4)]), expected: [.stack])
   assertEqual(actual: dataStructures([.insert(3), .insert(4), .insert(2), .pop(3), .pop(4)]), expected: [.queue])
   assertEqual(actual: dataStructures([.insert(3), .insert(4), .insert(5), .pop(5), .pop(4)]), expected: [.stack])
   assertEqual(actual: dataStructures([.insert(3), .insert(4), .insert(5), .pop(3), .pop(4)]), expected: [.queue, .priority])
   assertEqual(actual: dataStructures([.insert(3), .insert(4), .insert(5), .pop(5)]), expected: [.stack])
   assertEqual(actual: dataStructures([.insert(3), .insert(4), .insert(5), .insert(6), .pop(3), .pop(4), .pop(6)]), expected: [])
   assertEqual(actual: dataStructures([.insert(3), .insert(2), .insert(2), .insert(1), .pop(1)]), expected: [.stack, .priority])
   assertEqual(actual: dataStructures([.insert(3), .insert(4), .insert(2), .insert(2), .insert(1), .pop(1), .pop(2), .pop(2), .pop(4)]), expected: [.stack])
   assertEqual(actual: dataStructures([.insert(8), .insert(4), .insert(3), .insert(1), .insert(9), .insert(0), .insert(10), .insert(12), .pop(0), .pop(1), .pop(3)]), expected: [.priority])
   assertEqual(actual: dataStructures([.insert(8), .insert(4), .insert(3), .insert(1), .insert(9), .insert(0), .insert(10), .insert(12), .pop(0), .pop(1), .pop(4)]), expected: [])

print("Testing phone pad permutations")
print(PhonePadPermutations().letterCombinations("2345").count)
print(PhonePadPermutations().letterCombinations("2345"))

print("Testing Roman Numeral Conversion")
print(RomanNumeralConverter().intToRoman(3))
print(RomanNumeralConverter().intToRoman(6))
print(RomanNumeralConverter().intToRoman(9))
print(RomanNumeralConverter().intToRoman(555))
print(RomanNumeralConverter().intToRoman(49))
print(RomanNumeralConverter().intToRoman(899))
print(RomanNumeralConverter().intToRoman(0))
print(RomanNumeralConverter().intToRoman(-5))

print("ThreeSum")
print(OptimizedThreeSumSolver().threeSum([1,1,2,1,1,1,1]))

print("SortedTwoSum")
print(SortedTwoSum().twoSum([2,7,11,15], 9))
print(SortedTwoSum().twoSum([-1,0,1,2,3,4], 7))
print(SortedTwoSum().twoSum([-1,0,1,2,3,4], 3))
print(SortedTwoSum().twoSum([-1,0,1,2,3,4], 6))

let root = TreeNode(5)
let fourNode = TreeNode(4)
let eightNode = TreeNode(8)
let elevenNode = TreeNode(11)
let thirteenNode = TreeNode(13)
let fourNode2 = TreeNode(4)
let sevenNode = TreeNode(7)
let twoNode = TreeNode(2)
let oneNode = TreeNode(1)

elevenNode.left = sevenNode
elevenNode.right = twoNode
fourNode.left = elevenNode
fourNode2.right = oneNode
eightNode.left = thirteenNode
eightNode.right = fourNode2
root.left = fourNode
root.right = eightNode

print(PathSum().hasPathSum(root, 26))

print("Count Lakes")
let image: [[Character]] = [[".",".",".",".",".",".",".",".",".","."],
                            [".",".",".",".",".","X","X","X","X","."],
                            [".",".",".",".",".","X","X","X","X","."],
                            [".","X","X","X","X","X",".",".","X","X"],
                            [".","X","X",".","X","X",".","X",".","X"],
                            [".","X","X","X",".","X","X","X","X","X"],
                            [".",".",".",".",".",".",".",".",".","."],
                            [".",".",".",".",".",".",".",".",".","."]]

let imageTwo: [[Character]] = [[".",".",".",".",".","."],
                               ["X","X","X","X","X","."],
                               ["X",".","X",".",".","."],
                               ["X",".","X","X","X","."]]

print(countLakes(image, Position(row: 3, col: 3)))

print("Testing TopK Words")

let words = ["apples", "apples", "x", "foo", "apples", "apples", "x", "g", "apples", "bananas", "bananas", "g", "bananas", "fruits", "fruits", "hello", "manana", "fruits", "pies", "pies", "pies", "pies", "a", "a"]

print(TopKFrequentWords().topKFrequent(words, 6))

print("Testing TopK Elements")

let topKElements = [3, 2, 1, 1, 2, 1]

print(TopKFrequentElements().topKFrequent(topKElements, 2))

print("Binary Tree Printer/Formatter")
let leafNodeThree = TreeNode(3, nil, nil)
let leafNodeFour = TreeNode(4, nil, nil)
let childNodeTwo = TreeNode(2, nil, leafNodeFour)
let rootNode = TreeNode(1, childNodeTwo, leafNodeThree)
let treePrinter = BinaryTreeFormattedPrinterOne()
let formattedOutput = treePrinter.printTree(rootNode)
print(formattedOutput)


print("Spiral Traversal Tests:")
let numberMatrix: [[Int]] = [[1,2,3],
                             [5,6,7],
                             [8,9,10]]
let spiralOrder = SpiralMatrixTraversal().spiralOrder(numberMatrix)
print(spiralOrder)


print(isPowerOfTwo(4))


print("Min Path Sum Tests: ")
let minPathMatrix: [[Int]] = [[1,3,1],
                             [1,5,1],
                             [4,2,1]]
let minPathSumValue = MinPathSumDP().minPathSum(minPathMatrix)
print(minPathSumValue)

print("Testing LCA")
let seven = StringTreeNode(value: "7", left: nil, right: nil)
let four = StringTreeNode(value: "4", left: nil, right: nil)
let two = StringTreeNode(value: "2", left: seven, right: four)
let six = StringTreeNode(value: "6", left: nil, right: nil)
let five = StringTreeNode(value: "5", left: six, right: two)
let one = StringTreeNode(value: "1", left: nil, right: nil)
let threeRoot = StringTreeNode(value: "3", left: five, right: one)
let node = getCommonAncestor(threeRoot, seven, six)
print(node?.value)

print("Testing BSTMinDifference")

let six_node = TreeNode(6)
let eighteen_node = TreeNode(18)
let ten_node = TreeNode(10, six_node, eighteen_node)
let negative_two_node = TreeNode(-2)
let negative_eighteen_node = TreeNode(-18)
let negative_six_node = TreeNode(-6, negative_eighteen_node, negative_two_node)
let root_tree_node = TreeNode(3, negative_six_node, ten_node)

print(BSTMinDifference().getMinimumDifference(root_tree_node))

print("Testing Conflicting Events")
print(ConflictingEvents().haveConflict(["1:00","2:00"],["1:20","3:00"]))
print(ConflictingEvents().haveConflict(["1:20","3:00"],["1:00","2:00"]))
print(ConflictingEvents().haveConflict(["1:15","2:00"],["2:00","3:00"]))
print(ConflictingEvents().haveConflict(["2:00","3:00"],["1:15","2:00"]))
print(ConflictingEvents().haveConflict(["10:00","11:00"],["14:00","15:00"]))
print(ConflictingEvents().haveConflict(["14:00","15:00"],["10:00","11:00"]))
print(ConflictingEvents().haveConflict(["14:00","15:00"],["10:00","11:00"]))
print(ConflictingEvents().haveConflict(["14:00","18:00"],["16:00","17:00"]))
print(ConflictingEvents().haveConflict(["14:00","18:00"],["16:00","18:00"]))
print(ConflictingEvents().haveConflict(["14:00","18:00"],["14:00","15:00"]))
print(ConflictingEvents().haveConflict(["14:00","18:00"],["14:00","18:00"]))

print("Testing String subsequence combinations")
let subsequences = subsequenceCombinations("spec", 3)
print(subsequences)
let subsequencesMemoized = subsequenceCombinationsWithDP("spec", 3)
print(subsequencesMemoized)

let wordList: Set<String> = ["spe", "spc", "sec", "pec", "spec"]
print(isSpecialWord("spec", wordList))

print("Object Serialization Tests: ")
let aakash = Person("Aakash", "Kakumani", "408-423-8765", [])
let madhavi = Person("Madhavi", "Kakumani", "408-528-7216", [])
let dinesh = Person("Dinesh", "Kakumani", "408-386-4519", [aakash, madhavi])
let aaron = Person("Aaron", "Parker", "408-446-9087", [])
let abhay = Person("Abhay", "Curam", "408-440-7401", [aaron, dinesh])
dinesh.friends.append(abhay)

let ravi = Person("Ravi", "Curam", "NA", [])
let meema = Person("Meema", "Curam", "NA", [])
let krishna = Person("Krishna", "Curam", "408-528-0341", [ravi, meema])
let padma = Person("Padma", "Curam", "408-528-0341", [dinesh])
let ajay = Person("Ajay", "Curam", "408-440-7406", [abhay, krishna, padma])

let serializedDictionary = ajay.serializeToDictionary()
print(serializedDictionary)

print("Parenthesese Generation Tests: ")
print(GenerateParenthesese().generateParenthesis(1).count)
print(GenerateParenthesese().generateParenthesis(2).count)
print(GenerateParenthesese().generateParenthesis(3).count)
print(GenerateParenthesese().generateParenthesis(4).count)
print(GenerateParenthesese().generateParenthesis(5).count)
print(GenerateParenthesese().generateParenthesis(6).count)
print(GenerateParenthesese().generateParenthesis(7).count)
print(GenerateParenthesese().generateParenthesis(8).count)
print(GenerateParenthesese().generateParenthesis(9).count)
print(GenerateParenthesese().generateParenthesis(10).count)


print("Coalescing Adjacent Duplicates Tests: ")

var testArrayOne = [1,2,2,3,3,3,1]
var testArrayTwo = [1,1,1,1]
var testArrayThree = [1,2,3,2,1]

print(coalesceAdjacentDuplicates(testArrayOne))
print(coalesceAdjacentDuplicates(testArrayTwo))
print(coalesceAdjacentDuplicates(testArrayThree))

coalesceAdjacentDuplicatesInPlace(&testArrayOne)
coalesceAdjacentDuplicatesInPlace(&testArrayTwo)
coalesceAdjacentDuplicatesInPlace(&testArrayThree)
print(testArrayOne)
print(testArrayTwo)
print(testArrayThree)


let minPriorityQueue = BinaryHeap<Int>({ (lhs, rhs) -> Bool in
    return lhs < rhs
})

minPriorityQueue.insert(1)
minPriorityQueue.insert(1)
minPriorityQueue.insert(2)

print("CPU Task Scheduling Tests: ")
let taskScheduler = CPUTaskScheduler()
print(taskScheduler.leastInterval(["A","C","A","B","D","B"], 1))
print(taskScheduler.leastInterval(["A","A","A","B","B","B"], 2))
print(taskScheduler.leastInterval(["A","B","A"], 2))
print(taskScheduler.leastInterval(["B","C","D","A","A","A","A","G"], 1))
print(taskScheduler.leastInterval(["A","A","A","B","B","B","C","C","C","D","D","E"], 2))
print("hi")


print("Scooter Assignment Tests: ")
var scooterMap: [[Character]] = [["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","s","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["s","x","p","x","x","x","s","x","x","p","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","p","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"]]
let scooterAssignments = ScooterAssignment()
let nearestScooter = scooterAssignments.findClosestScooter(map: &scooterMap,
                                                           startPersonPosition: MapPosition(row: 4, col: 9))
print(nearestScooter)


print("Parens Validator Tests: ")

let parensOne = "{({[{}]})}"
print(ParenthesesValidator().isValid(parensOne))
let parensTwo = "{({[{}]})"
print(ParenthesesValidator().isValid(parensTwo))
let parensThree = "{({[{}]})}}"
print(ParenthesesValidator().isValid(parensThree))
let parensFour = "{({[{}]})}()"
print(ParenthesesValidator().isValid(parensFour))


print("Ordered Stack")
let orderedStack = SortedStack()
orderedStack.push(10)
orderedStack.push(0)
orderedStack.push(4)
orderedStack.push(3)
orderedStack.push(2)
orderedStack.push(8)

while !orderedStack.isEmpty() {
    print(orderedStack.pop())
}

print("/n")
print("Stack Sort")
var arrayStack = ArrayStack([10,0,4,3,2,8])
var sortedStack = sortStack(arrayStack)
while !sortedStack.isEmpty() {
    print(sortedStack.pop())
}
print("--------------")
arrayStack = ArrayStack([0,2,3,4,5,6,7,8])
sortedStack = sortStack(arrayStack)
while !sortedStack.isEmpty() {
    print(sortedStack.pop())
}
print("--------------")
arrayStack = ArrayStack([8,7,6,5,4,3,2])
sortedStack = sortStack(arrayStack)
while !sortedStack.isEmpty() {
    print(sortedStack.pop())
}
print("--------------")
arrayStack = ArrayStack([8])
sortedStack = sortStack(arrayStack)
while !sortedStack.isEmpty() {
    print(sortedStack.pop())
}
print("--------------")
arrayStack = ArrayStack([])
sortedStack = sortStack(arrayStack)
while !sortedStack.isEmpty() {
    print(sortedStack.pop())
}



print("/n")
print("Int To String")
print(StringToInt().myAtoi("    "))
print(StringToInt().myAtoi("123"))
print(StringToInt().myAtoi("    123"))
print(StringToInt().myAtoi("   +123 "))
print(StringToInt().myAtoi("   +12 3 "))
print(StringToInt().myAtoi("-123"))
print(StringToInt().myAtoi("+-123"))
print(StringToInt().myAtoi("   -12345c78"))
print(StringToInt().myAtoi("   +000"))
print(StringToInt().myAtoi("   -0000"))
print(StringToInt().myAtoi("   +000012"))
print(StringToInt().myAtoi("   -001+23"))
print(StringToInt().myAtoi("   -12345678910"))
print(StringToInt().myAtoi("-91283472332"))
print(StringToInt().myAtoi("   12345678910"))
print(StringToInt().myAtoi("-2147483649"))
print(StringToInt().myAtoi("2147483648"))
print(StringToInt().myAtoi("00000000000000000000000000000000004"))
print(StringToInt().myAtoi("123456009403985309432095025924"))
print(StringToInt().myAtoi("-123456009403985309432095025924"))

let backspaceStringComparison = BackspaceStringCompare()
print(backspaceStringComparison.backSpaceCompareUsingSlidingWindow("ab#c", "ad#c"))
print(backspaceStringComparison.backSpaceCompareUsingSlidingWindow("ab##", "c#d#"))
print(backspaceStringComparison.backSpaceCompareUsingSlidingWindow("ab#c", "ad#f"))
print(backspaceStringComparison.backSpaceCompareUsingSlidingWindow("bgef######d", "dc#"))
print(backspaceStringComparison.backSpaceCompareUsingSlidingWindow("bgef######d", "ac########d"))
