//
//  ListIntersection.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 3/30/26.
//

/**
 * Solution in O(N+M) time and O(1) space which is most optimal.
 */
class ListIntersection {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var cursor = headA
        var listACount = 0
        var listBCount = 0
        while cursor != nil {
            cursor = cursor?.next
            listACount += 1
        }
        cursor = headB
        while cursor != nil {
            cursor = cursor?.next
            listBCount += 1
        }
        
        let difference = abs(listACount - listBCount)
        var advancedRunner = listACount >= listBCount ? headA : headB
        var runner = (listACount >= listBCount) ? headB : headA
        var skipCount = difference
        while skipCount > 0 {
            advancedRunner = advancedRunner?.next
            skipCount -= 1
        }

        while runner != nil && advancedRunner != nil {
            if runner === advancedRunner {
                return runner
            }
            runner = runner?.next
            advancedRunner = advancedRunner?.next
        }
        
        return nil
    }
}
