//
//  PlusOne.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/10/26.
//

class AddOneSolver {
    /**
     * O(N) time and O(N) space, if the function passed in a reference we could save on space and do it in O(1)
     * Three passes, one to copy array, one to iterate through, then one additional linear pass if we have to insert
     * the carry at index 0 at the end.
     */
    func plusOne(_ digits: [Int]) -> [Int] {
        var result = digits
        let carryOver = 1
        for i in (0..<result.count).reversed() {
            let currentDigit = result[i]
            let positionSum = currentDigit + carryOver
            if positionSum == 10 {
                result[i] = 0
            } else {
                result[i] = positionSum
                return result
            }
        }
        
        /**
         * If we have gotten here this means we still have a carry over
         */
        result.insert(carryOver, at: 0)
        return result
    }
}
