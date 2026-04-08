//
//  Graph+TopologicalSort.swift
//  Graph
//
//  Created by Abhay Curam on 7/20/25.
//

extension Graph {
    
    /*
     * Gets a topological ordering of all the vertices in the graph (topological sort).
     * This algorithm uses a DFS post-order style traversal of the Graph to produce the
     * topological ordering. The time complexity of the algorithm is O(V+E), while the
     * space complexity is O(V). A recursiveSet is used to short circuit if the graph has cycles.
     * A full topological sort/order is not possible if a graph has a cycle.
     */
    public func getVerticesInTopologicalOrder() -> [Vertex]
    {
        var visitedSet = Set<Vertex>()
        var recursiveSet = Set<Vertex>()
        var result = [Vertex]()
        let vertices = getAllVertices()
        for vertex in vertices {
            if vertices.count == result.count { break }
            if !visitedSet.contains(vertex) {
                let foundCycle = recursivelyComputeTopologicalOrder(vertex, &visitedSet, &recursiveSet, &result)
                if foundCycle { return [] } //short-circuit
            }
        }
        return result.reversed()
    }
    
    public func getVertexIDsInTopologicalOrder() -> [String]
    {
        return getVerticesInTopologicalOrder().map { $0.id }
    }
    
    private func recursivelyComputeTopologicalOrder(_ currentVertex: Vertex,
                                                    _ visitedSet: inout Set<Vertex>,
                                                    _ recursiveSet: inout Set<Vertex>,
                                                    _ result: inout [Vertex]) -> Bool
    {
        visitedSet.insert(currentVertex)
        recursiveSet.insert(currentVertex)
        for adjacentVertex in getAllNeighborsForVertex(currentVertex.id) {
            if recursiveSet.contains(adjacentVertex) {
                recursiveSet.remove(currentVertex)
                return true
            } else {
                if !visitedSet.contains(adjacentVertex) {
                    let foundCycle = recursivelyComputeTopologicalOrder(adjacentVertex, &visitedSet, &recursiveSet, &result)
                    if foundCycle {
                        recursiveSet.remove(currentVertex)
                        return true
                    }
                }
            }
        }
        result.append(currentVertex)
        recursiveSet.remove(currentVertex)
        return false
    }
}
