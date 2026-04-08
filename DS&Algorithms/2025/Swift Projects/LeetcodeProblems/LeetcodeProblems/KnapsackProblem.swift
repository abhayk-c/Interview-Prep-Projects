//
//  KnapsackProblem.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/8/25.
//

func maxValueForKnapsack(_ capacity: Int, _ weights: [Int], _ values: [Int]) -> Int
{
    guard capacity >= 0 && weights.count == values.count else { return 0 }
    guard weights.count > 0 else { return 0 }
    var maxValueTable: [[Int]] = Array(repeating: Array(repeating: 0, count: capacity + 1), count: weights.count + 1)
    let rowCount = maxValueTable.count
    let colCount = maxValueTable[0].count
    for row in 1..<rowCount {
        for col in 0..<colCount {
            let currentItemWeight = weights[row-1]
            let currentItemValue = values[row-1]
            if currentItemWeight > col {
                maxValueTable[row][col] = maxValueTable[row-1][col]
            } else {
                maxValueTable[row][col] = max((currentItemValue + maxValueTable[row-1][col-currentItemWeight]),
                                              (maxValueTable[row-1][col]))
            }
        }
    }
    return maxValueTable[rowCount-1][colCount-1]
}

