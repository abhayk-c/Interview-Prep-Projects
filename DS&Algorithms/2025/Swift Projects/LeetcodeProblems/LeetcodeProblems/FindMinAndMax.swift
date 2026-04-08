//
//  FindMinAndMax.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 6/3/25.
//

/*
 * The goal of this problem is to try to find the min and max simultaneously,
 * with fewer than the standard 2N comparisons. (Actually 2N-1)
 *
 * I derived a probabilistic solution that should "converge" the number of comparisons
 * to 3n/2 on average which is less than 2N. That being said because its probabilistic
 * in nature there is always a chance that you get a lot of heads flips/tail flips
 * that makes the worst case # of comparisons non-deterministic and hard to guarantee.
 *
 * If we were programming for an amortized 3n/2 solution this would work.
 * But if we have to guarantee 3n/2 the book solution is better. That being said
 * 3n/2 is better.
 */
func findMinAndMax<T: Comparable>(elements: inout [T]) -> (min: T, max: T)?
{
    guard !elements.isEmpty else { return nil }
    var localMin = elements[0]
    var localMax = elements[0]
    for i in 1..<elements.count {
        let coinFlip = Int.random(in: 0...1)
        if coinFlip == 1 {
            if elements[i] >= localMax {
                localMax = elements[i]
            } else if elements[i] < localMin {
                localMin = elements[i]
            }
        } else {
            if elements[i] <= localMin {
                localMin = elements[i]
            } else if elements[i] > localMax {
                localMax = elements[i]
            }
        }
    }
    
    return (localMin, localMax)
}
