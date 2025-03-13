extension Graph where Vertex: Hashable & Equatable, Weight: Hashable {

    /// Runs the Floyd-Warshall algorithm on this graph.
    ///
    /// This function implements a generic Floyd-Warshall algorithm over a
    /// semiring defined on the graph’s edge weights. By supplying different
    /// semiring implementations, the function can flexibly compute various
    /// properties about the graph, such as the shortest paths between all pairs
    /// of vertices or the transitive closure of a relation represented by the
    /// graph.
    ///
    /// Example:
    ///
    /// ```swift
    /// let graph = AdjacencyListGraph(
    ///     [
    ///         "1": ["3": -2.0],
    ///         "2": ["1": 4.0, "3": 3.0],
    ///         "3": [:],
    ///         "4": ["2": -1.0],
    ///     ]
    /// )
    /// graph.runFloydWarshallAlgorithm(
    ///     semiring: newSemiring(
    ///         zero: Double.infinity,
    ///         one: 0.0,
    ///         add: min,
    ///         mul: +
    ///     )
    /// )
    /// ```
    ///
    /// Specialized versions of this function are provided for convenience:
    /// - Use ``shortestPaths()`` for finding shortest paths.
    /// - Use ``transitiveClosure()`` for finding transitive closure.
    ///
    /// - Parameter semiring: The semiring over the graph's edge weight type.
    ///
    /// - Returns: A structure with optimal paths and their weights.
    public func runFloydWarshallAlgorithm(
        semiring: any Semiring<Weight>
    ) -> FloydWarshallAlgorithmResult<Vertex, Weight> {
        floydWarshallAlgorithmImpl(graph: self, semiring: semiring)
    }
}


extension Graph where Vertex: Equatable {
    
    /// Finds the transitive closure of this graph.
    public func transitiveClosure() -> FloydWarshallAlgorithmResult<Vertex, Bool> {
        self.map{ _ in true }.runFloydWarshallAlgorithm(
            semiring: newSemiring(
                zero: false,
                one: true,
                add: { $0 || $1 },
                mul: { $0 && $1 }
            )
        )
    }
    
}


extension Graph where Vertex: Equatable, Weight == Double {
    
    /// Finds the shortest paths between any two vertices in this graph.
    public func shortestPaths() -> FloydWarshallAlgorithmResult<Vertex, Double> {
        runFloydWarshallAlgorithm(
            semiring: newSemiring(
                zero: Double.infinity,
                one: 0.0,
                add: min,
                mul: +
            )
        )
    }
}


func floydWarshallAlgorithmImpl<
    Vertex: Hashable & Equatable,
    Weight: Equatable
>(
    graph: any Graph<Vertex, Weight>,
    semiring: any Semiring<Weight>
) -> FloydWarshallAlgorithmResult<Vertex, Weight> {
    
    let vertices = graph.vertices
    
    var weights: [Pair<Vertex, Vertex>: Weight] = [:]
    var next: [Pair<Vertex, Vertex>: Vertex] = [:]

    for source in vertices {
        for target in vertices {
            let pair = Pair(source, target)
            if source == target {
                weights[pair] = semiring.one
                next[pair] = target
            }
            else if let weight = graph.weight(from: source, to: target) {
                weights[pair] = weight
                next[pair] = target
            }
            else {
                weights[pair] = semiring.zero
            }
        }
    }
        
    for waypoint in vertices {
        for source in vertices {
            for target in vertices {
                if source != waypoint && target != waypoint && source != target {
                    let weightViaWaypoint = semiring.mul(
                        weights[Pair(source, waypoint)]!,
                        weights[Pair(waypoint, target)]!
                    )
                    let currentWeight = weights[Pair(source, target)]!
                    weights[Pair(source, target)] = semiring.add(
                        currentWeight,
                        weightViaWaypoint
                    )
                    if weights[Pair(source, target)] == weightViaWaypoint {
                        next[Pair(source, target)] = next[Pair(source, waypoint)]
                    }
                }
            }
        }
    }
    
    return FloydWarshallAlgorithmResult(weights: weights, next: next)
}


/// Provides the result of the Floyd-Warshall algorithm.
public struct FloydWarshallAlgorithmResult<
    Vertex: Hashable & Equatable,
    Weight
> {
    let weights: [Pair<Vertex, Vertex>: Weight]
    let next: [Pair<Vertex, Vertex>: Vertex]
    
    /// Obtains the weight of the path from a source vertex to a target vertex.
    ///
    /// - Parameters:
    ///   - source: The vertex to start the path with.
    ///   - target: The vertex to end the path with.
    ///
    /// - Returns: The weight of the path connecting the two vertices.
    public func weight(from source: Vertex, to target: Vertex) -> Weight? {
        weights[Pair(source, target)]
    }
    
    /// Obtains the path from a source vertex to a target vertex.
    ///
    /// - Parameters:
    ///   - source: The vertex to start the path with.
    ///   - target: The vertex to end the path with.
    ///
    /// - Returns: The path connecting the two vertices.
    public func path(from source: Vertex, to target: Vertex) -> [Vertex]? {
        if next[Pair(source, target)] == nil {
            return nil
        }
        var path: [Vertex] = [source]
        var current: Vertex = source
        while current != target {
            guard let nextVertex = next[Pair(current, target)] else {
                return nil
            }
            current = nextVertex
            path.append(nextVertex)
        }
        return path
    }
}
