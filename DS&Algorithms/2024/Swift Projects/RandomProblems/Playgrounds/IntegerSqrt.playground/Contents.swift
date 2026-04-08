import UIKit
import Foundation

class Solution {
    func mySqrt(_ x: Int) -> Int {
        if x == 0 || x == 1 { return x }
        var startNum = 0
        var endNum = x - 1
        var candidateSquare = 0
        while (startNum <= endNum) {
            candidateSquare = startNum + ((endNum - startNum) / 2)
            if candidateSquare * candidateSquare == x {
                return candidateSquare
            } else if candidateSquare * candidateSquare > x {
                endNum = candidateSquare - 1
            } else {
                startNum = candidateSquare + 1
            }
        }

        /**
         * At this point startNum and endNum are guaranteed to be the same
         * value from above logic so just pick one.
         * You can't use candidateSquare because it's going to be the
         * "previous" value which might be +1 one candidate square above or behind
         * where we want to be
         */
        return startNum - 1
    }
}

let solution = Solution()
print("solution: ")
print(solution.mySqrt(6))

