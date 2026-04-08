//
//  CountLakes.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/23/25.
//

import Foundation


struct Position: Hashable {
  let row: Int
  let col: Int
}

func countLakes(_ image: [[Character]], _ touch: Position) -> Int {
  // First we need to DFS from the touch and basically get all neighboring
  // Blue Pixels. Equivalent of DFS searching the entire island from touch origin.
  // This identifies all bodies of water touching the island, which would include any lakes
  // within the island, and all the water pixels that encircle the island (can think of it as
  // shoreline pixels). I correctly identified we needed to DFS the whole island but
  // I was stuck on what we are searching for and how to use that information.
  // Basically DFS the island and store any water pixel you see in a hash-set.
  var visitedSet = Set<Position>()
  var observedWaterPixels = Set<Position>()
  dfsForWaterPixels(image, touch, &visitedSet, &observedWaterPixels)
  
  // Now we iterate through the neighboring water pixels and we identify all
  // water pixels that are "connected" (i.e. connected components/vertices). Connected water
  // pixels are either a contained lake, or the ocean pixels sorrounding the island.
  // Determining if pixels are connected
  // is just the same as running a DFS reachability search from a start position and storing
  // all nodes you've visted along the way, once the search is exhausted you are done. This is
  // also known as determining if vertices are "connected", "or connected components".
  var lakeCount = 0
  while (!observedWaterPixels.isEmpty) {
    var waterVisitedSet = Set<Position>()
    dfsWaterRegions(&waterVisitedSet, &observedWaterPixels, observedWaterPixels.first!)
    if !waterVisitedSet.isEmpty {
      // Once we've computed a subset of water pixels that are connected we know
      // we found a lake or the shoreline pixels enclosing the island.
      // We can safely remove it from our regions of water and increment lake count.
      // Once the observedWaterPixels Set
      // is empty we've explored all regions.
      for waterPosition in waterVisitedSet {
        observedWaterPixels.remove(waterPosition)
      }
      lakeCount += 1
    }
  }

  /**
   * Our lakeCount is just the number of connected water regions we computed
   * minus 1 to exclude the "shoreline" pixels. If we counted those we would count the
   * ocean as a lake.
   */
  return lakeCount > 0 ? lakeCount - 1 : 0
}

func dfsWaterRegions(_ waterVisitedSet: inout Set<Position>,
                     _ observedWaterPixels: inout Set<Position>,
                     _ current: Position)
{
  waterVisitedSet.insert(current)
  let dfsSearchPositions = getWaterDFSPositions(current)
  for nextPosition in dfsSearchPositions {
    if observedWaterPixels.contains(nextPosition) {
      if !waterVisitedSet.contains(nextPosition) {
        dfsWaterRegions(&waterVisitedSet, &observedWaterPixels, nextPosition)
      }
    }
  }
}

func dfsForWaterPixels(_ image: [[Character]],
                       _ current: Position,
                       _ visitedSet: inout Set<Position>,
                       _ observedWaterPixels: inout Set<Position>) {
  visitedSet.insert(current)
  let dfsSearchPositions = getIslandDFSPositions(current)
  for nextPosition in dfsSearchPositions {
    if isPositionValid(nextPosition, image) {
      if image[nextPosition.row][nextPosition.col] == "X" {
        if !visitedSet.contains(nextPosition) {
          dfsForWaterPixels(image, nextPosition, &visitedSet, &observedWaterPixels)
        }
      } else {
        observedWaterPixels.insert(nextPosition)
      }
    }
  }
}

func isPositionValid(_ position: Position, _ image: [[Character]]) -> Bool {
  return position.row >= 0 && position.row < image.count && position.col >= 0 && position.col < image[0].count
}

func getIslandDFSPositions(_ current: Position) -> [Position] {
  let north = Position(row: current.row - 1, col: current.col)
  let northEast = Position(row: current.row - 1, col: current.col + 1)
  let east = Position(row: current.row, col: current.col + 1)
  let southEast = Position(row: current.row + 1, col: current.col + 1)
  let south = Position(row: current.row + 1, col: current.col)
  let southWest = Position(row: current.row + 1, col: current.col - 1)
  let west = Position(row: current.row, col: current.col - 1)
  let northWest = Position(row: current.row - 1, col: current.col - 1)
  let dfsPositions = [north, northEast, east, southEast, south, southWest, west, northWest]
  return dfsPositions
}

func getWaterDFSPositions(_ current: Position) -> [Position] {
  let north = Position(row: current.row - 1, col: current.col)
  let east = Position(row: current.row, col: current.col + 1)
  let south = Position(row: current.row + 1, col: current.col)
  let west = Position(row: current.row, col: current.col - 1)
  let dfsPositions = [north, east, south, west]
  return dfsPositions
}
