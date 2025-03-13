extension SearchProblem where Cost: Comparable {
    
    /// Solves this search problem using Dijkstra's algorithm.
    ///
    /// - Returns: The solution to the search problem. If no path can be found,
    ///   `nil` is returned.
    public func solveUsingDijkstrasAlgorithm() -> Solution? {
        solve(
            with: ArrayBasedPriorityQueue<Node, Cost> { $0.accumulatedCost }
        )
    }
    
    /// Solves this search problem using Dijkstra's algorithm with the
    /// specified priority queue.
    ///
    /// - Parameter priorityQueue: A factory that creates the priority queue to
    ///     be used by the search algorithm.
    ///
    /// - Returns: The solution to the search problem, If no path can be found,
    ///   `nil` is returned.
    public func solveUsingDijkstrasAlgorithm(
        with priorityQueue: @autoclosure (() -> any PriorityQueue<Node, Cost>)
    ) -> Solution? {
        solve(with: priorityQueue())
    }
    
}

