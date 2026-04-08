//
//  TowersOfHanoi.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 7/3/25.
//

/**
 * This function simulates the towers of hanoi game and solves it,
 * moving all disks from towerOne to towerThree. The method simulates
 * the constraints of the game:
 * 1. Move only one disk at a time from top of a tower.
 * 2. No larger disk can be placed on top of smaller disk.
 *
 * Assumes valid arguments are supplied: disks are in descending order
 * disks are placed in towerOne. Towers 2 and 3 are empty.
 */
func simulateTowersOfHanoi(_ towerOne: inout [Int],
                           _ towerTwo: inout [Int],
                           _ towerThree: inout [Int])
{
    guard !towerOne.isEmpty else { return }
    guard towerTwo.isEmpty && towerThree.isEmpty else { return }
    recursivelyMoveDisks(towerOne.first!...towerOne.last!, &towerOne, &towerTwo, &towerThree)
}
        
func recursivelyMoveDisks(_ disksToMove: ClosedRange<Int>,
                          _ origin: inout [Int],
                          _ buffer: inout [Int],
                          _ dest: inout [Int])
{
    if disksToMove.lowerBound == disksToMove.upperBound {
        let disk = origin.removeLast()
        dest.append(disk)
        return
    }
    
    recursivelyMoveDisks(disksToMove.lowerBound+1...disksToMove.upperBound, &origin, &dest, &buffer)
    recursivelyMoveDisks(disksToMove.lowerBound...disksToMove.lowerBound, &origin, &buffer, &dest)
    recursivelyMoveDisks(disksToMove.lowerBound+1...disksToMove.upperBound, &buffer, &origin, &dest)
}
