extension Graph {
    
    /// The type of search problem represented by this graph.
    typealias GraphSearchProblem = SearchProblem<Vertex, Vertex, Weight>
    
    func makeSearchProblem(
        from source: Vertex,
        to target: Vertex,
        monoid: any Monoid<Weight>
    ) -> GraphSearchProblem {
        SearchProblem(
            initialState: source,
            isGoal: { $0 == target },
            actions: { vertex in
                Array(outgoingVertices(from: vertex))
            },
            transition: { $1 },
            cost: { edgeStartVertex, edgeEndVertex in
                weight(from: edgeStartVertex, to: edgeEndVertex)!
            },
            monoid: monoid
        )
    }
    
    /// Finds a path in this graph using the specified searcher.
    ///
    /// - Parameters:
    ///   - source: The starting vertex of the path to find.
    ///   - target: The ending vertex of the path to find.
    ///   - searcher: The searcher to use to find the path.
    ///   - monoid: The monoid to be used for accumulating the cost on the path.
    ///
    /// - Returns: The path found by the searcher. `nil` if no path can be found.
    public func path(
        from source: Vertex,
        to target: Vertex,
        searcher: any Searcher<Vertex, Vertex, Weight>,
        monoid: any Monoid<Weight>
    ) -> SearchProblemSolution<Vertex, Vertex, Weight>? {
        let searchProblem = makeSearchProblem(
            from: source,
            to: target,
            monoid: monoid
        )
        return searcher.solve(searchProblem)
    }

}


extension Graph where Weight: Numeric {
    
    func makeSearchProblem(
        from source: Vertex,
        to target: Vertex
    ) -> GraphSearchProblem {
        makeSearchProblem(
            from: source,
            to: target,
            monoid: newMonoid(id: Weight.zero, op: +)
        )
    }
    
    /// Finds a path in this graph using the specified searcher.
    ///
    /// - Parameters:
    ///   - source: The starting vertex of the path to find.
    ///   - target: The ending vertex of the path to find.
    ///   - searcher: The searcher to use to find the path.
    ///
    /// - Returns: The path found by the searcher. `nil` if no path can be found.
    public func path(
        from source: Vertex,
        to target: Vertex,
        searcher: any Searcher<Vertex, Vertex, Weight>
    ) -> SearchProblemSolution<Vertex, Vertex, Weight>? {
        let searchProblem = makeSearchProblem(
            from: source,
            to: target
        )
        return searcher.solve(searchProblem)
    }
    
}
