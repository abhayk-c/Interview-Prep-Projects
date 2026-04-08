//
//  CountingSort.swift
//  Sorting
//
//  Created by Abhay Curam on 6/12/25.
//

/*
 * Counting sort is a integer sorting algorithm that can sort integers in linear time
 * when the range of integer values in the array is fixed and known ahead of time.
 * If these properties hold counting sort can sort an array of integers in O(N + K) time
 * where K is the number of distinct values in the fixed range (also known as "keys") and
 * N is the number of elements in the array to sort. Leverage this algo when the size
 * of the key range is not significantly larger than the size of the unsorted input.
 * If your range of key values is too large, or much larger than the input array itself,
 * your better of pivoting to a radix sort or classical sorting technique.
 *
 * Algorithm Description:
 * Counting sort exploits the natural numerical ordering of integers in a "range."
 * It knows that if we are sorting an array of integers with values in the range [2, 8],
 * then the final sorted output must follow the number line ordering: [2, 3, 4, 5, ..., 8].
 * First, we iterate through the unsorted array and count the frequency of each unique
 * digit/value in the range in a count table. Then we, exploit the fact that if we encountered
 * 3 2's, then the next value 3 must be at least 3 indexes away from the value 2 in the
 * sorted output. We can call these "distances." We encode these distances into our count table
 * via computing and recording a running sum (aka indexed or prefixed sum). Once this is done
 * producing our final sorted array becomes trivial.
 *
 * Use Cases:
 * Counting Sort is perfect for sorting integers, but it can be applied to other sorting
 * problems as well. Any sorting problem that can be "reduced" to a integer counting sort
 * can be solved using this algorithm. If an unsorted array has a fixed range of values
 * (fixed key space) and the key space is sorted or has a natural numerical/lexicographical ordering,
 * the problem can be reduced to counting sort. Maps will be required to map the ordered
 * key space to indices and back from indices to keys (easy with hash table or a transform function),
 * once this is done a countTable can be constructed and Counting Sort can be applied. Examples are
 * sorting a small lexicographical range of strings, sorting strings with a custom ordered dictionary,
 * sorting students by grades (A, B, C, D, F), sorting by days of week, etc.
 */
func countingSort(_ nums: inout [Int],
                  _ order: SortOrder,
                  _ range: ClosedRange<Int>,
                  _ valueToIndexTransform: ((Int) -> Int)?) -> [Int]
{
    guard !nums.isEmpty else { return [] }
    guard range.lowerBound <= range.upperBound else { return [] }
    var countingTable: [Int] = Array(repeating: 0, count: range.upperBound - range.lowerBound + 1)
    var sortedResult: [Int] = Array(repeating: 0, count: nums.count)
    let offset = range.lowerBound
    // tabulate and count frequencies
    for i in 0..<nums.count {
        let current = nums[i]
        let countingTableIndex = valueToIndexTransform?(current) ?? current
        countingTable[countingTableIndex - offset] += 1
    }
    
    // Update table with running sum (encode distances)
    var runningSum = 0
    if order == .ascending {
        for i in 0..<countingTable.count {
            runningSum += countingTable[i]
            countingTable[i] = runningSum
        }
    } else {
        for i in (0..<countingTable.count).reversed() {
            runningSum += countingTable[i]
            countingTable[i] = runningSum
        }
    }
    
    // Perform right shift
    var prev = 0
    if order == .ascending {
        for i in 0..<countingTable.count {
            let current = countingTable[i]
            countingTable[i] = prev
            prev = current
        }
    } else {
        for i in (0..<countingTable.count).reversed() {
            let current = countingTable[i]
            countingTable[i] = prev
            prev = current
        }
    }
    
    // Write out sorted array
    for i in 0..<nums.count {
        let current = nums[i]
        let countingTableIndex = valueToIndexTransform?(current) ?? current
        let sortedIndex = countingTable[countingTableIndex - offset]
        sortedResult[sortedIndex] = current
        countingTable[countingTableIndex - offset] += 1
    }
    return sortedResult
}
