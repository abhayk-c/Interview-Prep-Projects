import Foundation

struct MapPosition: Hashable {
    let row: Int
    let col: Int
}

struct MapPositionWithDistance {
    let position: MapPosition
    let distance: Int
}

struct PersonScooterDistance {
    let person: MapPosition
    let scooter: MapPosition
    let distance: Int
}

class ScooterAssignment {

  /**
   * Algorithm Description:
   *
   * BFS from multiple origins with greedy distance based scooter assignment at the end.
   *
   * 1. Identify each person in the map and mark them as source/start vertices.
   * 2. Run an exhaustive BFS from each person (source vertex) and search the entire map,
   *    saving each scooter position and the distance traversed to the scooter. We save these
   *    results as tuples (Person, Scooter, Distance) in an array. These tuples are essentially edges.
   * 3. From step 2 take all (Person, Scooter, Distance) tuples and store them in a flat array,
   *    sort all of these tuples by distance in ascending order.
   * 4. Iterate through sorted array and greedily assign scooters to people. If a current person and scooter
   *    is unassigned we match them and mark them as assigned. Because we always consider tuples (edges)
   *    in order of increasing distance each scooter is always claimed by the closest available person,
   *    and each person gets the closest "available" scooter.
   *
   * Time Complexity: O(MP + PSlog(PS)) where M is size of map, P is num persons, S is num scooters.
   * BFS could be avoided if we mark all scooter positions and person positions and compute pair-wise
   * distances, but BFS is more scalable in real-world mapping scenario (obstacles, untraversable paths, etc.)
   *
   */
  public func findClosestScooter(map: inout [[Character]],
                                 startPersonPosition: MapPosition) -> MapPosition? {
      let startPositions = getAllPersonsOnMap(&map)
      var allScooterDistances: [PersonScooterDistance] = []
      for startPosition in startPositions {
          let scooterDistances = findAllScootersWithDistances(startPosition, &map)
          allScooterDistances.append(contentsOf: scooterDistances)
      }
      
      // Sort by distance in ascending order.
      allScooterDistances.sort(by: { $0.distance < $1.distance })
      
      // Greedily match people with scooters.
      var personToScooterAssignments: [MapPosition: MapPositionWithDistance] = [:]
      var scooterToPersonAssignments: [MapPosition: MapPositionWithDistance] = [:]
      for distancePair in allScooterDistances {
          let curPerson = distancePair.person
          let curScooter = distancePair.scooter
          let curDistance = distancePair.distance
          if personToScooterAssignments[curPerson] == nil && scooterToPersonAssignments[curScooter] == nil {
              //The current person and scooter haven't been assigned yet so we make an assignment.
              personToScooterAssignments[curPerson] = MapPositionWithDistance(position: curScooter, distance: curDistance)
              scooterToPersonAssignments[curScooter] = MapPositionWithDistance(position: curPerson, distance: curDistance)
          }
      }
      
      // Either return the matched scooter or "nil"
      return personToScooterAssignments[startPersonPosition]?.position
    }
    
    /**
     * Get all persons on the map. This is equivalent to finding all source vertices for the algo.
     */
    private func getAllPersonsOnMap(_ map: inout [[Character]]) -> [MapPosition] {
        var sources: [MapPosition] = []
        for row in 0..<map.count {
            for col in 0..<map[0].count {
                if map[row][col] == "p" {
                    sources.append(MapPosition(row: row, col: col))
                }
            }
        }
        return sources
    }
    
    /*
     * For a person (source vertex) search for all scooters and store the position of each scooter found
     * on the map and it's distance. We store as a 3-tuple (personPosition, scooterPosition, distance).
     * We use an exhaustive BFS.
     */
    private func findAllScootersWithDistances(_ startPersonPosition: MapPosition,
                                              _ map: inout [[Character]]) -> [PersonScooterDistance] {
        var visitedSet = Set<MapPosition>()
        var traversalQueue: [MapPositionWithDistance] = [MapPositionWithDistance(position: startPersonPosition, distance: 0)]
        var scooterDistances: [PersonScooterDistance] = []
        while !traversalQueue.isEmpty {
            let currentNode = traversalQueue.removeFirst()
            let currentPosition = currentNode.position
            let currentDistance = currentNode.distance
            if map[currentPosition.row][currentPosition.col] == "s" {
                let personScooterDistance = PersonScooterDistance(person: startPersonPosition, scooter: currentPosition, distance: currentDistance)
                scooterDistances.append(personScooterDistance)
            }
            //Traversal
            if currentPosition.row - 1 >= 0 {
                let northPosition = MapPosition(row: currentPosition.row - 1, col: currentPosition.col)
                let northPositionWithDistance = MapPositionWithDistance(position: northPosition, distance: currentDistance + 1)
                if !visitedSet.contains(northPosition) {
                    visitedSet.insert(northPosition)
                    traversalQueue.append(northPositionWithDistance)
                }
            }
            if currentPosition.col + 1 < map[0].count {
                let rightPosition = MapPosition(row: currentPosition.row, col: currentPosition.col + 1)
                let rightPositionWithDistance = MapPositionWithDistance(position: rightPosition, distance: currentDistance + 1)
                if !visitedSet.contains(rightPosition) {
                    visitedSet.insert(rightPosition)
                    traversalQueue.append(rightPositionWithDistance)
                }
            }
            if currentPosition.row + 1 < map.count {
                let southPosition = MapPosition(row: currentPosition.row + 1, col: currentPosition.col)
                let southPositionWithDistance = MapPositionWithDistance(position: southPosition, distance: currentDistance + 1)
                if !visitedSet.contains(southPosition) {
                    visitedSet.insert(southPosition)
                    traversalQueue.append(southPositionWithDistance)
                }
            }
            if currentPosition.col - 1 >= 0 {
                let leftPosition = MapPosition(row: currentPosition.row, col: currentPosition.col - 1)
                let leftPositionWithDistance = MapPositionWithDistance(position: leftPosition, distance: currentDistance + 1)
                if !visitedSet.contains(leftPosition) {
                    visitedSet.insert(leftPosition)
                    traversalQueue.append(leftPositionWithDistance)
                }
            }
        }
        return scooterDistances
    }

}

print("Scooter Assignment Tests: ")

/*
 * In this test case person at position (4,9) will be assigned a scooter but is assigned the
 * scooter farthest distance away from them because the closer scooters are assigned to other people
 * who are closer.
 */
var scooterMap: [[Character]] = [["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","s","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["s","x","p","x","x","x","s","x","x","p","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","p","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                 ["x","x","x","x","x","x","x","x","x","x","x","x"]]
let scooterAssignments = ScooterAssignment()
let nearestScooter = scooterAssignments.findClosestScooter(map: &scooterMap,
                                                           startPersonPosition: MapPosition(row: 4, col: 9))
print(nearestScooter ?? "nil")

/*
 * In this test case person at position (4,9) will NOT be assigned a scooter because other people
 * are closer to the available scooters on the map and are assigned the scooters first.
 */
var scooterMapTwo: [[Character]] = [["x","x","x","x","x","x","x","x","x","x","x","x"],
                                    ["x","x","x","x","s","x","x","x","x","x","x","x"],
                                    ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                    ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                    ["x","x","p","x","x","x","s","x","x","p","x","x"],
                                    ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                    ["x","x","x","x","x","x","p","x","x","x","x","x"],
                                    ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                    ["x","x","x","x","x","x","x","x","x","x","x","x"],
                                    ["x","x","x","x","x","x","x","x","x","x","x","x"]]
let nearestScooterTwo = scooterAssignments.findClosestScooter(map: &scooterMapTwo,
                                                              startPersonPosition: MapPosition(row: 4, col: 9))
print(nearestScooterTwo ?? "nil")
