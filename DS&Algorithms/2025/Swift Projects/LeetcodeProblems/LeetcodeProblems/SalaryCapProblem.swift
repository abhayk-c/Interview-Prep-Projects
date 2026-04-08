//
//  SalaryCapProblem.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 6/16/25.
//

import Foundation

/*
 * Solution the salary cap problem in EIP (Problem 13.11).
 * This is a O(NLogN + N) ~ O(NLogN) time solution that requires O(N) space.
 * My solution was to sort the array then compute a sort of reverse prefix sum,
 * where the sum is actually the difference (so computing a reverse prefix difference).
 * I intuitively thought in terms of computing the top K salaries to "fix/cap."
 * This performs as good as the book's solution and they are intuitively the same.
 */
func applySalaryCap(_ salaries: inout [Int], _ salaryCap: Int) -> [Int]
{
    guard !salaries.isEmpty else { return [] }
    var currentTotal = 0
    for i in 0..<salaries.count { currentTotal += salaries[i] }
    guard salaryCap < currentTotal else { return salaries }
    salaries.sort(by: <)
    var cappedSalariesCount = 1
    var cappedSalaryIndex = salaries.count - 1
    var computedSavings = 0
    for index in (0..<salaries.count).reversed() {
        if index < salaries.count - 1 {
            let prevCappedSalariesCount = salaries.count - 1 - index
            let localSavings = ((salaries[index+1] - salaries[index]) * prevCappedSalariesCount) + computedSavings
            if currentTotal - localSavings < salaryCap {
                break
            } else {
                computedSavings = localSavings
                cappedSalaryIndex = index
                cappedSalariesCount = prevCappedSalariesCount + 1
            }
        }
    }
    
    var adjustmentAmount = currentTotal - computedSavings - salaryCap
    adjustmentAmount = Int(ceil(Double(adjustmentAmount) / Double(cappedSalariesCount)))
    let maxSalary = salaries[cappedSalaryIndex] - adjustmentAmount
    var adjustedSalaries = Array(repeating: maxSalary, count: salaries.count)
    for i in 0..<adjustedSalaries.count - cappedSalariesCount {
        adjustedSalaries[i] = salaries[i]
    }
    return adjustedSalaries
}
