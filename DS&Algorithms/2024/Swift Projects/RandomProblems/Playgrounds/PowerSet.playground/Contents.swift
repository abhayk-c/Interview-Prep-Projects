import UIKit
import Foundation

/**
 * Iterative implementation to power set algorithm
 * using DP and Divide/Conquer strategy
 */
func subsets(_ nums: [Int]) -> [[Int]] {
    var subsets: [[Int]] = [[]]
    var i = 0
    while i < nums.count {
        var cartesianProduct : [[Int]] = []
        var j = 0
        while j < subsets.count {
            var setProduct = subsets[j]
            setProduct.append(nums[i])
            cartesianProduct.append(setProduct)
            j+=1
        }
        subsets.append(contentsOf: cartesianProduct)
        i+=1
    }
    return subsets
}

print(subsets([1,2,3,4]))
print(subsets([1,2,3,4]).count)
