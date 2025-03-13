/// A weighted directed graph.
public protocol Graph<Vertex, Weight> {
    
    /// The type the vertices in the graph represent.
    associatedtype Vertex: Hashable
    
    /// The type used for edge weights.
    associatedtype Weight
    
    /// All vertices in the graph.
    var vertices: Set<Vertex> { get }
    
    /// Returns the set of vertices that can be reached directly from the given
    /// vertex via its outgoing edges.
    ///
    /// - Parameter vertex: The vertex to start from.
    ///
    /// - Returns: The set of vertices that can be reached directly by the given
    ///   vertex using its outgoing edges.
    func outgoingVertices(from vertex: Vertex) -> Set<Vertex>
    
    /// Returns the weight of a directed edge in the graph.
    ///
    /// - Parameters:
    ///   - source: The starting vertex of the edge.
    ///   - target: The ending vertex of the edge.
    ///
    /// - Returns: The weight of the edge.
    func weight(from source: Vertex, to target: Vertex) -> Weight?
}
