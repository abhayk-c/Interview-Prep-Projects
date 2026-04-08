//
//  TransformWords.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/22/25.
//

/*
 * Problem 18.7 in Elements of Programming Interviews
 */
struct TransformedWord: Comparable {
    let currentWord: String
    let destinationWord: String
    let traversedDistance: Int
    public init(_ currentWord: String, _ destinationWord: String, _ traversedDistance: Int) {
        self.currentWord = currentWord
        self.destinationWord = destinationWord
        self.traversedDistance = traversedDistance
    }
    static func < (lhs: TransformedWord, rhs: TransformedWord) -> Bool {
        let lhsDiff = computeWordDistance(lhs.currentWord, lhs.destinationWord) + lhs.traversedDistance
        let rhsDiff = computeWordDistance(rhs.currentWord, rhs.destinationWord) + rhs.traversedDistance
        return lhsDiff < rhsDiff
    }
}

/**
 * I solved this problem leveraging a variant of Dijkstra's, where cost in the priority queueso is:
 * (distance traveled to current word) + (difference of current word to the goal). By modeling the
 * problem this way I thought I could use a priority queue to greedily pick the best edge
 * (next transformation word) and find the shortest path. The approach worked.
 * Apparently I derived the A-star search algorithm on my own.
 *
 * Time Complexity: O(V^2 + EklogE) where V is number of words in dictionary, E is edges, and k is word size.
 * Space Complexity: Bounded by O(V + E) space needed for adjacency list. The priority queue uses O(E)
 *
 * I could have simplified this problem and did a basic BFS which is what the book does. That reduces the
 * time complexity to O(V^2 + V + E). I actually tried BFS but I abandoned it too quicky,thinking it
 * would be too naiive of an approach to solve this problem. If I incorporated a BFS reversePathMap
 * I would have seen that BFS would have clearly worked as well.
 */
func computeShortestWordProductionSequence(_ source: String, _ dest: String, _ wordSet: Set<String>) -> [String]
{
    guard source.count == dest.count else { return [] }
    var reversePathMap = [String : String]()
    var visitedSet = Set<String>()
    let adjacencyList = getAdjacencyListRepresentation(wordSet: wordSet, characterCount: source.count)
    let priorityQueue = BinaryHeap<TransformedWord>({(lhs: TransformedWord, rhs: TransformedWord) -> Bool in
        return lhs < rhs
    })
    priorityQueue.insert(TransformedWord(source, dest, 0))
    visitedSet.insert(source)
    while (!priorityQueue.isEmpty()) {
        guard let transformedWord = priorityQueue.pop() else { return [] }
        let distance = transformedWord.traversedDistance
        if transformedWord.currentWord == dest {
            return pathFromReversePathMap(reversePathMap, dest)
        }
        if let edgeWords = adjacencyList[transformedWord.currentWord] {
            for edgeWord in edgeWords {
                if !visitedSet.contains(edgeWord) {
                    priorityQueue.insert(TransformedWord(edgeWord, dest, distance+1))
                    reversePathMap[edgeWord] = transformedWord.currentWord
                    visitedSet.insert(edgeWord)
                }
            }
        }
    }
    return []
}

func getAdjacencyListRepresentation(wordSet: Set<String>, characterCount: Int) -> [String: [String]]
{
    let filteredWords = wordSet.filter { $0.count == characterCount }
    var adjacencyList = [String: [String]]()
    for vertexWord in filteredWords {
        adjacencyList[vertexWord] = []
        for edgeWord in filteredWords {
            let diff = wordDifference(vertexWord, edgeWord)
            if diff == characterCount - 1 {
                adjacencyList[vertexWord]?.append(edgeWord)
            }
        }
    }
    return adjacencyList
}

func pathFromReversePathMap(_ reversePathMap: [String : String], _ dest: String) -> [String]
{
    var pathResult = [String]()
    pathResult.append(dest)
    var currWord: String? = dest
    while let pathWord = currWord {
        if let nextWord = reversePathMap[pathWord] {
            pathResult.append(nextWord)
        }
        currWord = reversePathMap[pathWord]
    }
    return pathResult.reversed()
}

func wordDifference(_ wordOne: String, _ wordTwo: String) -> Int
{
    let wordOneArray = Array(wordOne)
    let wordTwoArray = Array(wordTwo)
    var distance = wordOne.count
    for i in 0..<wordOneArray.count {
        if wordOneArray[i] != wordTwoArray[i] { distance -= 1 }
    }
    return distance
}
