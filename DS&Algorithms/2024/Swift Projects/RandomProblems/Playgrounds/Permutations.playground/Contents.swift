import UIKit

func permute(_ nums: [Int]) -> [[Int]] {
    var mutableNums = nums
    return permuteRecursively(&mutableNums, 0, nums.count - 1)
}

func permuteRecursively(_ nums: inout [Int], _ si: Int, _ ei: Int) -> [[Int]]
{
    if si == ei { return [[nums[si]]] }
    let subArrayPermutations = permuteRecursively(&nums, si+1, ei)
    var permutations: [[Int]] = []
    var fixIndex = 0
    var capacity = (ei - si) + 1
    while fixIndex < capacity {
        for subArrayPermutation in subArrayPermutations {
            var permutation: [Int] = Array(repeating: 0, count: capacity)
            permutation[fixIndex] = nums[si]
            var i = 0
            var j = 0
            while i < subArrayPermutation.count {
                if j == fixIndex { j += 1 }
                permutation[j] = subArrayPermutation[i]
                i += 1
                j += 1
            }
            permutations.append(permutation)
        }
        fixIndex += 1
    }
    return permutations
}

print(permute([1, 2, 3, 4]))
