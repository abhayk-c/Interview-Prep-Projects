//
//  Graph+Dijkstras.swift
//  Graph
//
//  Created by Abhay Curam on 7/20/25.
//

/**
 * Public Minimum Cost Path Finding API's (Dijkstra's)
 */
extension Graph {
    
    private struct VertexWithCost: Comparable {
        let vertexID: String
        let totalCost: Int
        
        static func < (lhs: VertexWithCost, rhs: VertexWithCost) -> Bool {
            return lhs.totalCost < rhs.totalCost
        }
        static func == (lhs: VertexWithCost, rhs: VertexWithCost) -> Bool {
            return lhs.totalCost == rhs.totalCost
        }
    }
    
    private struct EdgeWithCost {
        let edge: Edge
        let totalCost: Int
    }
    
    /**
     * Returns the minimum cost path from (u,v) via implementing Dijkstra's Algorithm.
     * This algo runs in O((E+V)logE) time complexity and uses O(E) space in the worst case.
     * The space complexity is bounded by the heap space used, which is the set of all edges.
     * Then the algorithm must visit every vertex and edge and perform a heap insert and/or delete
     * which will take log(E) time. Care has to be taken when reconstructing the "path",
     * we use a hash-map which makes the path tracking constant time and only store what's
     * needed (back edges/back pointers). Its essentially a "reverse" lookup map/table.
     */
    public func minimumCostPath(from sourceVertexID: String,
                                to destinationVertexID: String) -> (path: [Edge], cost: Int)
    {
        guard let _ = getVertex(sourceVertexID), let _ = getVertex(destinationVertexID) else {
            return ([], 0)
        }
        let minHeap = BinaryHeap<VertexWithCost>(comparatorBlock: {(lhs: VertexWithCost, rhs: VertexWithCost) -> Bool in
            return lhs < rhs
        })
        
        var visitedSet = Set<String>()
        var minPathTable = Dictionary<String, EdgeWithCost>()
        minHeap.insert(VertexWithCost(vertexID: sourceVertexID, totalCost: 0))
        while !minHeap.isEmpty() {
            if let currentVertex = minHeap.pop() {
                if currentVertex.vertexID == destinationVertexID { break }
                if !visitedSet.contains(currentVertex.vertexID) {
                    visitedSet.insert(currentVertex.vertexID)
                    for edge in getAllEdgesForVertex(currentVertex.vertexID) {
                        if !visitedSet.contains(edge.sinkVertexID) {
                            let updatedCost = currentVertex.totalCost + edge.weight
                            minHeap.insert(VertexWithCost(vertexID: edge.sinkVertexID, totalCost: updatedCost))
                            if let currentPath = minPathTable[edge.sinkVertexID] {
                                if updatedCost < currentPath.totalCost {
                                    minPathTable[edge.sinkVertexID] = EdgeWithCost(edge: edge, totalCost: updatedCost)
                                }
                            } else {
                                minPathTable[edge.sinkVertexID] = EdgeWithCost(edge: edge, totalCost: updatedCost)
                            }
                        }
                    }
                }
            }
        }
        
        if minPathTable[destinationVertexID] != nil {
            var reversePath: EdgeWithCost? = minPathTable[destinationVertexID]
            let totalPathCost = reversePath?.totalCost ?? 0
            var minCostPath = [Edge]()
            while reversePath != nil {
                if let currentReversePath = reversePath {
                    minCostPath.append(currentReversePath.edge)
                    reversePath = minPathTable[currentReversePath.edge.sourceVertexID]
                }
            }
            return (minCostPath.reversed(), totalPathCost)
        }
        return ([], 0)
    }
    
}
