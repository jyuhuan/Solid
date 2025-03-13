extension SearchProblem {
    
    /// Solves this search problem using breadth-first search.
    ///
    /// - Returns: The solution to the search problem. If no path can be found,
    ///   `nil` is returned.
    public func solveUsingBreadthFirstSearch() -> Solution? {
        solve(with: ArrayBasedFIFOQueue<Node>())
    }
    
    /// Solves this search problem using breadth-first search with the specified
    /// FIFO queue.
    ///
    /// - Parameter fifoQueue: A factory that creates the FIFO queue to be used
    ///   by the search algorithm.
    ///
    /// - Returns: The solution to the search problem. If no path can be found,
    ///   `nil` is returned.
    public func solveUsingBreadthFirstSearch(
        with fifoQueue: @autoclosure () -> any FIFOQueue<Node>
    ) -> Solution? {
        solve(with: fifoQueue())
    }

}
