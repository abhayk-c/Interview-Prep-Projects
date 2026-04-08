//
//  TopKWords.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/3/25.
//

class TopKFrequentWords {
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var frequencyMap: [String : Int] = [:]
        var invertedFrequencyMap: [Int : Set<String>] = [:]
        for term in words {
            var termCount = 1
            if let frequencyCount = frequencyMap[term] {
                termCount = frequencyCount
                termCount += 1
            }
            frequencyMap[term] = termCount
            if invertedFrequencyMap[termCount - 1] != nil {
                invertedFrequencyMap[termCount - 1]?.remove(term)
            }
            if invertedFrequencyMap[termCount] != nil {
                invertedFrequencyMap[termCount]?.insert(term)
            } else {
                invertedFrequencyMap[termCount] = Set<String>([term])
            }
        }

        let sortedKeys = invertedFrequencyMap.keys.sorted(by: >)
        var topKTerms: [String] = []
        var termsAddedCount = 0
        for termCountKey in sortedKeys {
            if termsAddedCount >= k { break }
            if let currentBucketTerms = invertedFrequencyMap[termCountKey] {
                let currentBucketCount = currentBucketTerms.count
                if termsAddedCount + currentBucketCount < k {
                    topKTerms += currentBucketTerms.sorted()
                    termsAddedCount += currentBucketCount
                } else {
                    let numTermsToAdd = currentBucketCount - ((termsAddedCount + currentBucketCount) - k)
                    topKTerms += Array(currentBucketTerms.sorted().prefix(numTermsToAdd))
                    termsAddedCount += numTermsToAdd
                }
            }
        }

        return topKTerms
    }
}
