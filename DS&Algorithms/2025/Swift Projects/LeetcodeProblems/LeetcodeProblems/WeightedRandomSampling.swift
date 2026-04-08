//
//  WeightedRandomStringGenerator.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/23/25.
//

/**
 * This solves the very similar leetcode problem.
 * This is a O(logN) solution that identifies we don't need to store
 * a range but just the upperBound scalar float value associated with each
 * string. Reduces the data we needed to store. This is nothing but a
 * prefix-sum representation. Again we simply perform a slightly modified
 * binary search to retrieve the "index."
 */
class WeightedRandomSampler {

    struct PrefixSumIndex {
        let index: Int
        let sum: Double
    }
    
    private let indexedWeights: [Int]
    private var prefixSumIndexes = [PrefixSumIndex]()
    
    init(_ w: [Int]) {
        indexedWeights = w
        preProcessRanges()
    }
    
    func pickIndex() -> Int {
        let rand = Double.random(in: 0..<1)
        let index = binarySearchForIndex(rand, 0, prefixSumIndexes.count - 1)
        return (index >= 0 && index < prefixSumIndexes.count) ? index : -1
    }
    
    private func preProcessRanges() {
        var total = indexedWeights.reduce(0) { (partialResult, element) in return partialResult + element }
        var lower: Double = 0
        for i in 0..<indexedWeights.count {
            let normalizedWeight = Double(indexedWeights[i]) / Double(total)
            let upper = lower + normalizedWeight
            prefixSumIndexes.append(PrefixSumIndex(index: i, sum: upper))
            lower = upper
        }
    }
    
    private func binarySearchForIndex(_ target: Double, _ startIndex: Int, _ endIndex: Int) -> Int {
        if startIndex > endIndex { return -1 }
        let midIndex = (startIndex + ((endIndex - startIndex) / 2))
        let curPrefixSum = prefixSumIndexes[midIndex].sum
        if target <= curPrefixSum {
            if midIndex - 1 >= 0 {
                if target > prefixSumIndexes[midIndex - 1].sum {
                    return midIndex
                } else {
                    return binarySearchForIndex(target, startIndex, midIndex - 1)
                }
            } else {
                return midIndex
            }
        } else {
            return binarySearchForIndex(target, midIndex + 1, endIndex)
        }
    }
}


/**
 * Optimized solution if we are able to precompute results/save state.
 * Again this was the optimized solution I came up with on the interview.
 * This preprocesses the strings and associates/map them to ranges on the number
 * line and then stores. The computation/math ensures these ranges are stored
 * sorted/ordered without any sorting needed. Then we we do a random() call where
 * we simply generate a random number and perform a binary search to return the string.
 * O(logN)
 */
class WeightedRandomStringGenerator {
    
    struct StringWithRange {
        let string: String
        let range: Range<Double>
    }
    
    private let stringWeights: [String : Double]
    private var orderedStringRanges = [StringWithRange]()
    
    public init(_ stringWeightDictionary: [String : Double]) {
        stringWeights = stringWeightDictionary
        preProcessStringRanges()
    }
    
    public func generateRandomString() -> String {
        guard !stringWeights.isEmpty && !orderedStringRanges.isEmpty else { return "" }
        let rand = Double.random(in: 0..<1)
        let index = binarySearchForRangeIndex(rand, 0, orderedStringRanges.count - 1)
        return (index >= 0 && index < orderedStringRanges.count) ? orderedStringRanges[index].string : ""
    }
    
    private func binarySearchForRangeIndex(_ target: Double, _ startIndex: Int, _ endIndex: Int) -> Int {
        if startIndex > endIndex { return -1 }
        let midIndex = (startIndex + ((endIndex - startIndex) / 2))
        let curStringRange = orderedStringRanges[midIndex]
        if target >= curStringRange.range.lowerBound && target <= curStringRange.range.upperBound {
            return midIndex
        } else if target <= curStringRange.range.lowerBound && target <= curStringRange.range.upperBound {
            return binarySearchForRangeIndex(target, startIndex, midIndex - 1)
        } else {
            return binarySearchForRangeIndex(target, midIndex + 1, endIndex)
        }
    }
    
    private func preProcessStringRanges() {
        var lower: Double = 0
        for (stringKey, normalizedWeight) in stringWeights {
            let upper = lower + normalizedWeight
            let range = lower..<upper
            orderedStringRanges.append(StringWithRange(string: stringKey, range: range))
            lower = upper
        }
    }
    
}


/*
 * Brute force solution that uses Ranges.
 * This was my approach in the interview.
 */
public func generateRandomString(_ stringWeights: [String: Double]) -> String
{
    var stringRanges: [String: ClosedRange<Double>] = [:]
    var runningRange: Double = 0
    for (stringKey, normalizedWeight) in stringWeights {
        let upperBound = runningRange + normalizedWeight
        let range = runningRange...upperBound
        stringRanges[stringKey] = range
        runningRange = upperBound
    }
    let rand = Double.random(in: 0...1)
    for (stringKey, range) in stringRanges {
        if rand >= range.lowerBound && rand <= range.upperBound {
            return stringKey
        }
    }
    return ""
}

/*
 * Brute force solution that skips constructing a Range
 * dictionary, slightly cleaner and tigher but time complexity is the same.
 */
public func generateString(_ stringWeights: [String : Double]) -> String
{
    var rand = Double.random(in: 0...1)
    var lower: Double = 0
    for (stringKey, weight) in stringWeights {
        let upper = lower + weight
        if rand >= lower && rand <= upper { return stringKey }
        lower = upper
    }
    return ""
}
