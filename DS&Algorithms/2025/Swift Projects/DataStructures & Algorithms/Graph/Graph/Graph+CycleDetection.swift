//
//  Graph+CycleDetection.swift
//  Graph
//
//  Created by Abhay Curam on 7/20/25.
//

/*
 * Graph Cycle Detection
 */
extension Graph {
    
    /*
     * Performs a DFS to detect cycles, the DFS begins at each vertex in the
     * graph to search the entire graph. A visitedSet is used globally to skip
     * over recursively searching already visited vertices.
     * Runs in O(E + V) time complexity, using O(V) space (stack and visited set)
     * A recursiveSet is used to help us detect cycles. If we find the same vertex
     * on a current recursive path/branch then we have a cycle. We can't use the
     * visited set because not all vertexes may be connected to each other.
     */
    public func containsCycle() -> Bool
    {
        var visitedSet = Set<Vertex>()
        var recursiveSet = Set<Vertex>()
        for vertex in getAllVertices() {
            if !visitedSet.contains(vertex) {
                let foundCycle = recursiveDFSForCycle(vertex, &recursiveSet, &visitedSet)
                if foundCycle { return true }
            }
        }
        return false
    }
    
    private func recursiveDFSForCycle(_ currentVertex: Vertex,
                                      _ recursiveSet: inout Set<Vertex>,
                                      _ visitedSet: inout Set<Vertex>) -> Bool
    {
        recursiveSet.insert(currentVertex)
        visitedSet.insert(currentVertex)
        for neighborVertex in getAllNeighborsForVertex(currentVertex.id) {
            if recursiveSet.contains(neighborVertex) {
                recursiveSet.remove(currentVertex)
                return true
            }
            if !visitedSet.contains(neighborVertex) {
                let foundCycle = recursiveDFSForCycle(neighborVertex, &recursiveSet, &visitedSet)
                if foundCycle {
                    recursiveSet.remove(currentVertex)
                    return true
                }
            }
        }
        recursiveSet.remove(currentVertex)
        return false
    }
    
}
