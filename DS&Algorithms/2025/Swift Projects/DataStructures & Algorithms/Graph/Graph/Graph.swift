//
//  Graph.swift
//  Graph
//
//  Created by Abhay Curam on 7/16/25.
//

public struct Vertex : Hashable {
    public let id: String
    public let data: Any?
    
    public init(id: String, data: Any?) {
        self.id = id
        self.data = data
    }
    
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public typealias Edge = (sourceVertexID: String, sinkVertexID: String, weight: Int)

/*
 A Graph data structure implemented in Swift using an adjacency list.
 This API mirrors the spirit of Python’s NetworkX graph — prioritizing ease of use
 over strict contract enforcement. The graph is **mutable** and tries to be forgiving:
 
 • Vertices do **not** need to be manually added. If a vertex doesn't exist
   when adding an edge, it will be automatically created.
 • Once a vertex or edge is added, use the corresponding `updateVertex(...)`
   or `updateEdge(...)` method to change their data or weight. Calling `add(...)`
   again will not overwrite existing data.
 • This implementation assumes a **directed graph**. To represent an
   undirected graph, the caller should explicitly add both directions:
   `(u, v)` and `(v, u)`.
 • The graph supports weighted edges and can model multigraphs.
 */
public class Graph<V: Any>: CustomStringConvertible {
    
    private var vertexMap: [String: Vertex] = [:]
    private var adjacencyList: [String : [Edge]] = [:]
    
    public var description: String {
        var output = "Graph:\n"
        for (sourceID, edges) in adjacencyList {
            let sourceData = vertexMap[sourceID]?.data.map { "\($0)" } ?? "nil"
            let edgesDescription = edges.map { edge in
                "\(edge.sinkVertexID)(w:\(edge.weight))"
            }.joined(separator: ", ")
            output += "  \(sourceID)(\(sourceData)) -> [\(edgesDescription)]\n"
        }
        return output
    }
    
    /**
     * Public API's for adding, deleting, and updating vertexes.
     */
    public func addVertex(_ vertexID: String, _ value: Any?)
    {
        let vertex = Vertex(id: vertexID, data: value)
        if vertexMap[vertexID] == nil && adjacencyList[vertexID] == nil {
            vertexMap[vertexID] = vertex
            adjacencyList[vertexID] = []
        }
    }
    
    public func updateValueAtVertex(_ vertexID: String, _ value: Any?)
    {
        let vertex = Vertex(id: vertexID, data: value)
        vertexMap[vertexID] = vertex
    }
    
    public func removeVertex(_ vertexID: String)
    {
        vertexMap[vertexID] = nil
        adjacencyList[vertexID] = nil
        for key in adjacencyList.keys {
            if let edges = adjacencyList[key] {
                let newEdges = edges.filter{ $0.sinkVertexID != vertexID }
                adjacencyList[key] = newEdges
            }
        }
    }
    
    /*
     * Public API's for querying vertexes
     */
    public func getVertex(_ vertexID: String) -> Vertex?
    {
        return vertexMap[vertexID]
    }
    
    public func getAllVertices() -> [Vertex]
    {
        return Array(vertexMap.values)
    }
    
    
    /*
     * Public API's for adding, deleting, and updating edges from (u, v)
     */
    public func addEdge(from sourceVertexID: String, to sinkVertexID: String, weight: Int)
    {
        let sourceVertex = vertexMap[sourceVertexID] ?? Vertex(id: sourceVertexID, data: nil)
        let sinkVertex = vertexMap[sinkVertexID] ?? Vertex(id: sinkVertexID, data: nil)
        let edge: Edge = (sourceVertexID: sourceVertexID, sinkVertexID: sinkVertexID, weight: weight)
        if vertexMap[sourceVertexID] != nil && adjacencyList[sourceVertexID] != nil {
            adjacencyList[sourceVertexID]?.append(edge)
            if vertexMap[sinkVertexID] == nil && adjacencyList[sinkVertexID] == nil {
                vertexMap[sinkVertexID] = sinkVertex
                adjacencyList[sinkVertexID] = []
            }
        } else {
            adjacencyList[sourceVertexID] = [edge]
            vertexMap[sourceVertexID] = sourceVertex
            if vertexMap[sinkVertexID] == nil { vertexMap[sinkVertexID] = sinkVertex }
            if adjacencyList[sinkVertexID] == nil { adjacencyList[sinkVertexID] = [] }
        }
    }
    
    // Removes the edge (u, v) with specific weight w.
    public func removeEdge(from sourceVertexID: String, to sinkVertexID: String, weight: Int)
    {
        if let edgeList = adjacencyList[sourceVertexID] {
            let newEdgeList = edgeList.filter { return !($0.sinkVertexID == sinkVertexID && $0.weight == weight) }
            adjacencyList[sourceVertexID] = newEdgeList
        }
    }
    
    // Removes all outgoing edges from u to v
    public func removeEdge(from sourceVertexID: String, to sinkVertexID: String)
    {
        if let edgeList = adjacencyList[sourceVertexID] {
            let newEdgeList = edgeList.filter { return $0.sinkVertexID != sinkVertexID }
            adjacencyList[sourceVertexID] = newEdgeList
        }
    }
    
    public func removeAllEdgesForVertex(_ id: String)
    {
        adjacencyList[id] = []
    }
    
    public func updateEdgeWithWeight(from sourceVertexID: String,
                                     to sinkVertexID: String,
                                     oldWeight: Int,
                                     newWeight: Int,
                                     firstMatch: Bool = true)
    {
        if let edgeList = adjacencyList[sourceVertexID] {
            var updateIndices = [Int]()
            for i in 0..<edgeList.count {
                if edgeList[i].sourceVertexID == sourceVertexID && edgeList[i].sinkVertexID == sinkVertexID && edgeList[i].weight == oldWeight {
                    updateIndices.append(i)
                    if firstMatch { break }
                }
            }
            for index in updateIndices {
                adjacencyList[sourceVertexID]?[index].weight = newWeight
            }
        }
    }
    
    public func updateEdgesWithWeight(from sourceVertexID: String, to sinkVertexID: String, newWeight: Int)
    {
        if let edgeList = adjacencyList[sourceVertexID] {
            for i in 0..<edgeList.count {
                if edgeList[i].sourceVertexID == sourceVertexID && edgeList[i].sinkVertexID == sinkVertexID {
                    adjacencyList[sourceVertexID]?[i].weight = newWeight
                }
            }
        }
    }
    
    /*
     * Public API's for querying adjacent and neighboring vertices.
     * Public API's for querying edges.
     */
    public func getEdge(from sourceVertexID: String, to sinkVertexID: String, weight: Int) -> Edge?
    {
        if let edges = adjacencyList[sourceVertexID] {
            for edge in edges {
                if edge.sourceVertexID == sourceVertexID && edge.sinkVertexID == sinkVertexID && edge.weight == weight {
                    return edge
                }
            }
        }
        return nil
    }
    
    public func getEdges(from sourceVertexID: String, to sinkVertexID: String) -> [Edge]
    {
        if let edges = adjacencyList[sourceVertexID] {
            return edges.filter { $0.sinkVertexID == sinkVertexID }
        }
        return []
    }
    
    public func getAllEdgesForVertex(_ id: String) -> [Edge]
    {
        return adjacencyList[id] ?? []
    }
    
    public func getAllEdges() -> [Edge]
    {
        var edgeList = [Edge]()
        for (_ , edges) in adjacencyList {
            edgeList += edges
        }
        return edgeList
    }
    
    public func getAllNeighborsForVertex(_ id: String) -> [Vertex]
    {
        return adjacencyList[id]?.compactMap{ vertexMap[$0.sinkVertexID] } ?? []
    }
    
    public func isAdjacent(from sourceVertexID: String, to sinkVertexID: String) -> Bool
    {
        if let edges = adjacencyList[sourceVertexID] {
            for edge in edges {
                if edge.sinkVertexID == sinkVertexID { return true }
            }
        }
        return false
    }
}

/**
 * Path finding and reachability API's on the Graph Data Structure
 * that leverage DFS, and BFS.
 */
extension Graph {
    
    /*
     * Implements a graph reachability API by performing a recursive DFS.
     * The time complexity is O(V + E), in the worst case every vertex and edge is
     * recursively explored. The space complexity is O(V), in the worst case the
     * recursive stack frames/space used is equivalent to the vertex set.
     */
    public func doesPathExist(from sourceVertexID: String,
                              to destinationVertexID: String) -> Bool
    {
        guard let sourceVertex = vertexMap[sourceVertexID],
              let destinationVertex = vertexMap[destinationVertexID] else { return false }
        var visitedVertices = Set<Vertex>()
        return recursiveDFS(from: sourceVertex, to: destinationVertex, &visitedVertices)
    }
    
    /*
     * Implements a shortest path-returning API from (u,v) ignoring cost by
     * implementing a standard BFS. The space used is bounded by the queue which
     * is O(V) in the worst case. The time complexity of a standard BFS should be O(V + E)
     * when using a traditional queue data structure (O(1) insert and deletion) and
     * a hash-map style DS for reverse path tracking. Unfortunately this algorithm does
     * not employ this so the true time complexity balloons to (O(V^2) + O(EV)).
     * This is because first, we use a dynamic array instead of a queue. This makes our
     * removeFront() operation linear in time (O(V)), so that becomes a linear "shift"
     * O(V + E) times. Then furthermore, the way we track the path is by repeatedly
     * copying and modiying the "path" at each vertex so far. These modifications and copies
     * are also a linear O(V) operation each time (the largest path is bounded by O(V).
     *
     * To optimize we could implement path tracking like we do for Dijkstra's, simple
     * reverse path tracking map. That would reduce the time complexity to constant time.
     * Then we could use a LinkedList for the queue instead of an array. That would bring
     * the runtime truly to O(E+V)
     */
    public func shortestPathIgnoringWeights(from sourceVertexID: String,
                                            to destinationVertexID: String) -> [Edge]
    {
        guard let sourceVertex = vertexMap[sourceVertexID],
              let destinationVertex = vertexMap[destinationVertexID] else { return [] }
        var visitedVertices = Set<Vertex>()
        var traversalQueue = [(vertex: Vertex, path: [Edge])]()
        traversalQueue.append((sourceVertex, []))
        while !traversalQueue.isEmpty {
            let current = traversalQueue.removeFirst()
            if current.vertex == destinationVertex { return current.path }
            visitedVertices.insert(current.vertex)
            let neighboringEdges = getAllEdgesForVertex(current.vertex.id)
            for edge in neighboringEdges {
                if let neighborVertex = vertexMap[edge.sinkVertexID], !visitedVertices.contains(neighborVertex) {
                    var nextPath = current.path
                    nextPath.append(edge)
                    traversalQueue.append((neighborVertex, nextPath))
                }
            }
        }
        return []
    }
    
    private func recursiveDFS(from sourceVertex: Vertex,
                              to destinationVertex: Vertex,
                              _ visitedSet: inout Set<Vertex>) -> Bool
    {
        if sourceVertex == destinationVertex { return true }
        visitedSet.insert(sourceVertex)
        for neighborVertex in getAllNeighborsForVertex(sourceVertex.id) {
            if !visitedSet.contains(neighborVertex) {
                let pathExists = recursiveDFS(from: neighborVertex, to: destinationVertex, &visitedSet)
                if pathExists { return true }
            }
        }
        return false
    }
    
}
