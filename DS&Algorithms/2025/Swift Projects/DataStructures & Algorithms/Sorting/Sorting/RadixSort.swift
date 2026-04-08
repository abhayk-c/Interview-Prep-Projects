//
//  RadixSort.swift
//  Sorting
//
//  Created by Abhay Curam on 6/13/25.
//

/*
 * Radix sort Description:
 * Radix sort is a linear time integer sorting algorithm.
 * Radix sort sorts the numbers in an array digit by digit starting from LSB to MSB.
 * At each digit we do a counting sort on the input array and the range of values is [0-9].
 * After sorting all the values digit by digit all the array's elements are in sorted order.
 * The fact that sorting numbers digit by digit can result in a final sorted output may be
 * surprising but it exploits this key observation: In lexicographic (or positional) orderings,
 * the first differing digit (or character) from left to right determines the ordering of two values.
 * The means the differing digit (or character) at the MSB (most significant position) determines
 * the final ordering. This property is what radix sort exploits — it defers sorting decisions until
 * the most significant distinguishing position is processed. But since we don’t know that position
 * in advance for all values, we sort all positions — from least to most significant — using a stable sort.
 * By sorting digits from right to left (LSD radix), we ensure that when we reach the most significant
 * differing digit between two values, the relative order decided at that point sticks, because all later
 * digits were sorted stably. Tbh its a bunch of jargon, going through example digit by digit it makes
 * more sense.
 *
 * Algorithm Details:
 * The time complexity of radix sort is O(K(N+B)) which becomes linear time O(N) when K and B < N.
 * N is the num elements in the unsorted input array, K is the number of digits for the number with the
 * largest digit sequence in the array (can be the max value or min value if sorting negative numbers),
 * and B is the range of values each digit can be ([0, 9] if sorting digit by digit). The space complexity
 * is bounded by O(N+B) at any given time which drops to O(N). Instead of sorting digit by digit (base 10),
 * you can sort in buckets of every 2 digits (base 100) or even sort by bytes. The algorithm below sorts from
 * least significant byte to most significant byte, which changes the digit range from [0, 9] to [0, 255].
 * Changing the digit (or bucket) size, increases the size of constant B, while decreasing K, often times
 * yielding a much faster algorithm.
 *
 * Known Issue:
 * My approach to handle negative values is to have the user supply an offset and normalize the input data
 * before sorting. This actually scales because for 32-bit int the range of valyes is [-2^31, 2^31] which
 * is still just 2^32 integers anyway. That being said to handle this cleanly the sorting step should be
 * storing UInt's, not Int's. Then when writing back to sorted array we can cast back to Int.
 *
 * Applications and Use Cases:
 * Unlike counting sort, radix sort can be used to sort any large array of integers without needing to
 * care about the range of integer values. Why? Because the largest value an int32 can be is 2^32, which
 * is just 9 digits. This yields a linear time integer sort that works for any array of integers (int64
 * same thing, i'll leave it as an exercise). Radix sort can be applied when the elements to sort have
 * fixed length keys, the keys can be broken down into components, and the components themselves come from
 * a ordered set that can be mapped to a range of integers for counting sort. Effectively this means the
 * key components, and the key itself, follow a numeric or lexicographic ordering. Examples of applications
 * that fall into this category: sorting BigInt's (256Bit Int, 128Bit Int), sorting fixed length strings,
 * sorting timestamps "YYYYMMDDHHMMSS", sorting structs or DB records by multiple key's where each key is
 * less significant than the other, sorting IP Addresses.
 *
 */
func base256RadixSort(_ nums: inout [Int], _ sortOrder: SortOrder, _ offset: Int) -> [Int]
{
    var k = 0
    let fixedMask = 255
    var sortedNums = nums
    while k <= Int.bitWidth - 8 {
        sortedNums = countingSort(&sortedNums,
                                  sortOrder,
                                  0...255,
                                  { (valueToTransform: Int) -> Int in
            var transformedValue = valueToTransform + offset
            let shiftedMask = fixedMask << k
            transformedValue &= shiftedMask
            return (transformedValue >> k)
        })
        k += 8
    }
    return sortedNums
}
