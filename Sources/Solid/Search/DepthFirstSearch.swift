extension SearchProblem {
    
    /// Solves this search problem using depth-first search.
    ///
    /// - Returns: The solution to the search problem. If no path can be found,
    ///   `nil` is returned.
    public func solveUsingDepthFirstSearch() -> Solution? {
        solve(with: ArrayBasedStack<Node>())
    }
    
    /// Solves this search problem using depth-first search with the specified
    /// stack.
    ///
    /// - Parameter stack: A factory that creates the stack to be used by the
    ///   search algorithm.
    ///
    /// - Returns: The solution to the search problem. If no path can be found,
    ///   `nil` is returned.
    public func solveUsingDepthFirstSearch(
        with stack: @autoclosure () -> any Stack<Node>
    ) -> Solution? {
        solve(with: stack())
    }
    
}
