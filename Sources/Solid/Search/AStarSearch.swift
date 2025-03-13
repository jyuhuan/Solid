extension SearchProblem where Cost: Comparable {
    
    /// Solves this search problem using A\* search.
    ///
    /// - Parameter heuristic: The heuristic function.
    ///
    /// - Returns: The solution to the search problem. If no path can be found,
    ///   `nil` is returned.
    public func solveUsingAStarSearch(
        heuristic: @escaping (State) -> Cost
    ) -> Solution? {
        solve(
            with: ArrayBasedPriorityQueue<Node, Cost>(
                prioritizedBy: { node in
                    monoid.op(node.accumulatedCost, heuristic(node.state))
                }
            )
        )
    }

    /// Solves this search problem using A\* search with the specified priority
    /// queue.
    ///
    /// - Parameters:
    ///   - heuristic: The heuristic function.
    ///   - priorityQueue: A factory that creates the priority queue to be used
    ///       by the A\* search algorithm. The heuristic function is passed as
    ///       an input parameter when this factory is called.
    ///
    /// - Returns: The solution to the search problem. If no path can be found,
    ///   `nil` is returned.
    public func solveUsingAStarSearch(
        heuristic: @escaping (State) -> Cost,
        priorityQueue: (@escaping (State) -> Cost) -> any PriorityQueue<Node, Cost>
    ) -> Solution? {
        solve(with: priorityQueue(heuristic))
    }

}

