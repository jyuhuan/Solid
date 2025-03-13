struct TransformedGraph<Vertex: Hashable, OriginalWeight, NewWeight>: Graph {
    
    typealias Vertex = Vertex
    typealias Weight = NewWeight
    
    let original: any Graph<Vertex, OriginalWeight>
    let weightTransformation: (OriginalWeight) -> NewWeight
    
    init(
        original: any Graph<Vertex, OriginalWeight>,
        weightTransformation: @escaping (OriginalWeight) -> NewWeight
    ) {
        self.original = original
        self.weightTransformation = weightTransformation
    }

    var vertices: Set<Vertex> {
        original.vertices
    }

    func outgoingVertices(from vertex: Vertex) -> Set<Vertex> {
        original.outgoingVertices(from: vertex)
    }
    
    func weight(from source: Vertex, to target: Vertex) -> NewWeight? {
        original.weight(from: source, to: target).flatMap(weightTransformation)
    }

}


extension Graph {
    
    ///  Returns a new graph in which the edge weights are transformed.
    ///
    ///  The following example doubles the weights on all edges:
    ///
    ///  ```swift
    ///  let graph = AdjacencyListGraph(
    ///      [
    ///          "1": ["3": -2.0],
    ///          "2": ["1": 4.0, "3": 3.0],
    ///          "3": [:],
    ///          "4": ["2": -1.0],
    ///      ]
    ///  )
    ///  let newGraph = graph.map { $0 * 2 }
    ///  ```
    ///
    ///  Note that the transformation closure won't be called right away. It
    ///  will be called when an edge weight in the new graph is queried.
    ///
    /// - Parameter transform: A transformation closure that returns a new
    ///   weight for each weight in this graph.
    ///
    /// - Returns: A new graph with new weights resulting from the
    ///   transformation.
    public func map<NewWeight>(
        _ transform: @escaping (Weight) -> NewWeight
    ) -> some Graph<Vertex, NewWeight> {
    
        TransformedGraph(
            original: self,
            weightTransformation: transform
        )
        
    }
    
}
