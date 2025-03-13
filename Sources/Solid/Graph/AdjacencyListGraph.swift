/// A weighted directed graph defined by an adjacency list.
///
/// Use this struct to easily create a weighted directed graph object that
/// conforms to the ``Graph`` protocol.
///
/// Example:
///
/// ```swift
/// let graph: any Graph = AdjacencyListGraph(
///     [
///         "A": ["C": -2.0],
///         "B": ["A": 4.0, "C": 3.0],
///         "C": [:],
///         "D": ["B": -1.0],
///     ]
/// )
/// ```
public struct AdjacencyListGraph<Vertex: Hashable, Weight>: Graph {
    
    /// The adjacency list defining the graph.
    public let adjacencyList: [Vertex: [Vertex: Weight]]
    
    init(_ adjacencyList: [Vertex: [Vertex: Weight]]) {
        self.adjacencyList = adjacencyList
    }

    public var vertices: Set<Vertex> {
        Set(self.adjacencyList.keys)
    }
    
    public func outgoingVertices(from vertex: Vertex) -> Set<Vertex> {
        Set(adjacencyList[vertex]!.keys)
    }
    
    public func weight(from source: Vertex, to target: Vertex) -> Weight? {
        self.adjacencyList[source]?[target]
    }
}
