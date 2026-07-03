//
//  PhoneDirectory.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/2/26.
//

/**
 * HashSet based solution that uses O(N) space where N is the size of maxNumbers.
 * Time complexity of get(), check(), release() are all O(1).
 */
class PhoneDirectory {

    private var availableNumbers = Set<Int>()
    private var usedNumbers = Set<Int>()
    
    init(_ maxNumbers: Int) {
        for i in 0..<maxNumbers {
            availableNumbers.insert(i)
        }
    }
    
    func get() -> Int {
        guard let firstAvailableNumber = availableNumbers.first else { return -1 }
        availableNumbers.remove(firstAvailableNumber)
        usedNumbers.insert(firstAvailableNumber)
        return firstAvailableNumber
    }
    
    func check(_ number: Int) -> Bool {
        return availableNumbers.contains(number)
    }
    
    func release(_ number: Int) {
        usedNumbers.remove(number)
        availableNumbers.insert(number)
    }
}
