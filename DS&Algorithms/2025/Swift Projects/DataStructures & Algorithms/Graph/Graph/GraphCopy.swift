//
//  GraphCopy.swift
//  Graph
//
//  Created by Abhay Curam on 7/17/25.
//

/**
 * A struct utility that leverages BFS to help deep copy a graph.
 */
struct GraphCopy {
    
    private init() {}
    
    /*
     * Leverages a BFS to deep copy a graph vertex by vertex and edge by edge.
     * Because we return a new graph the space complexity is O(E + V).
     * Our queue uses O(V) space in the worst case.
     *
     * If we were using a standard queue data structure, the time complexity
     * would be O(E + V), but because we are using an array as our queue the
     * removeFront() operation is not optimal. Our time complexity is O(V^2 + EV)
     */
    static func deepCopyGraph<V: Any>(_ graph: Graph<V>) -> Graph<V>
    {
        let newGraph = Graph<V>()
        var visitedSet = Set<Vertex>()
        var traversalQueue = [Vertex]()
        for vertex in graph.getAllVertices() {
            if !visitedSet.contains(vertex) {
                newGraph.addVertex(vertex.id, vertex.data)
                traversalQueue.append(vertex)
                visitedSet.insert(vertex)
                while !traversalQueue.isEmpty {
                    let currentVertex = traversalQueue.removeFirst()
                    let neighboringEdges = graph.getAllEdgesForVertex(currentVertex.id)
                    let neighboringVertices = graph.getAllNeighborsForVertex(currentVertex.id)
                    for adjacentVertix in neighboringVertices {
                        if !visitedSet.contains(adjacentVertix) {
                            newGraph.addVertex(adjacentVertix.id, adjacentVertix.data)
                            traversalQueue.append(adjacentVertix)
                            visitedSet.insert(adjacentVertix)
                        }
                    }
                    for outEdge in neighboringEdges {
                        newGraph.addEdge(from: outEdge.sourceVertexID, to: outEdge.sinkVertexID, weight: outEdge.weight)
                    }
                }
            }
        }
        return newGraph
    }
    
}
