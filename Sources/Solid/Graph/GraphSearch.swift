extension Graph {
    
    /// The type of search problem represented by this graph.
    public typealias GraphSearchProblem = SearchProblem<Vertex, Vertex, Weight>
    
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
    
    
    public func depthFirstSearch(
        from source: Vertex,
        to target: Vertex,
        using monoid: any Monoid<Weight>,
        with stack: @autoclosure () -> any Stack<GraphSearchProblem.Node>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target,
            monoid: monoid
        ).solveUsingDepthFirstSearch(with: stack())
    }
    
    public func depthFirstSearch(
        from source: Vertex,
        to target: Vertex,
        using monoid: any Monoid<Weight>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target,
            monoid: monoid
        ).solveUsingDepthFirstSearch()
    }
    
    
    public func breadthFirstSearch(
        from source: Vertex,
        to target: Vertex,
        using monoid: any Monoid<Weight>,
        with fifoQueue: @autoclosure () -> any FIFOQueue<GraphSearchProblem.Node>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target,
            monoid: monoid
        ).solveUsingBreadthFirstSearch(with: fifoQueue())
    }
    
    public func breadthFirstSearch(
        from source: Vertex,
        to target: Vertex,
        using monoid: any Monoid<Weight>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target,
            monoid: monoid
        ).solveUsingBreadthFirstSearch()
    }
    
}


extension Graph where Weight: Comparable {
    
    public func dijkstrasAlgorithmSearch(
        from source: Vertex,
        to target: Vertex,
        using monoid: any Monoid<Weight>,
        with priorityQueue: @autoclosure () -> any PriorityQueue<GraphSearchProblem.Node, Weight>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target,
            monoid: monoid
        ).solveUsingDijkstrasAlgorithm(with: priorityQueue())
    }
    
    public func dijkstrasAlgorithmSearch(
        from source: Vertex,
        to target: Vertex,
        using monoid: any Monoid<Weight>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target,
            monoid: monoid
        ).solveUsingDijkstrasAlgorithm()
    }
    
    
    public func aStarSearch(
        from source: Vertex,
        to target: Vertex,
        using monoid: any Monoid<Weight>,
        heuristic: @escaping (Vertex) -> Weight,
        priorityQueue: (@escaping (Vertex) -> Weight) -> any PriorityQueue<GraphSearchProblem.Node, Weight>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target,
            monoid: monoid
        ).solveUsingAStarSearch(heuristic: heuristic, priorityQueue: priorityQueue)
    }
    
    public func aStarSearch(
        from source: Vertex,
        to target: Vertex,
        using monoid: any Monoid<Weight>,
        heuristic: @escaping (Vertex) -> Weight
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target,
            monoid: monoid
        ).solveUsingAStarSearch(heuristic: heuristic)
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

    
    public func depthFirstSearch(
        from source: Vertex,
        to target: Vertex,
        with stack: @autoclosure () -> any Stack<GraphSearchProblem.Node>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target
        ).solveUsingDepthFirstSearch(with: stack())
    }
    
    /// Finds the path between two vertices using depth-first search.
    public func depthFirstSearch(
        from source: Vertex,
        to target: Vertex
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target
        ).solveUsingDepthFirstSearch()
    }
    
    
    public func breadthFirstSearch(
        from source: Vertex,
        to target: Vertex,
        with fifoQueue: @autoclosure () -> any FIFOQueue<GraphSearchProblem.Node>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target
        ).solveUsingBreadthFirstSearch(with: fifoQueue())
    }
    
    /// Finds the path between two vertices using breadth-first search.
    public func breadthFirstSearch(
        from source: Vertex,
        to target: Vertex
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target
        ).solveUsingBreadthFirstSearch()
    }


}

extension Graph where Weight: Numeric & Comparable {
    
    public func dijkstrasAlgorithmSearch(
        from source: Vertex,
        to target: Vertex,
        with priorityQueue: @autoclosure () -> any PriorityQueue<GraphSearchProblem.Node, Weight>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target
        ).solveUsingDijkstrasAlgorithm(with: priorityQueue())
    }
    
    /// Finds the shortest path between two vertices using Dijkstra's algorithm.
    public func dijkstrasAlgorithmSearch(
        from source: Vertex,
        to target: Vertex
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target
        ).solveUsingDijkstrasAlgorithm()
    }
    
    
    public func aStarSearch(
        from source: Vertex,
        to target: Vertex,
        heuristic: @escaping (Vertex) -> Weight,
        priorityQueue: (@escaping (Vertex) -> Weight) -> any PriorityQueue<GraphSearchProblem.Node, Weight>
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target
        ).solveUsingAStarSearch(heuristic: heuristic, priorityQueue: priorityQueue)
    }

    /// Finds the shortest path between two vertices using A\* search.
    public func aStarSearch(
        from source: Vertex,
        to target: Vertex,
        heuristic: @escaping (Vertex) -> Weight
    ) -> GraphSearchProblem.Solution? {
        makeSearchProblem(
            from: source,
            to: target
        ).solveUsingAStarSearch(heuristic: heuristic)
    }

}
