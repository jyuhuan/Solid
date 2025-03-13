extension SearchProblem {
    
    /// Solve this search problem using a queue.
    ///
    /// If a well-known search strategy (such as depth-first search) suits your
    /// need, don't use this method. Instead,
    ///
    ///  - Use ``solveUsingDepthFirstSearch()`` for depth-first search,
    ///  - Use ``solveUsingBreadthFirstSearch()`` for breadth-first search,
    ///  - Use ``solveUsingDijkstrasAlgorithm()`` for Dijkstra's algorithm, or
    ///  - Use ``solveUsingAStarSearch(heuristic:)`` for A\* search.
    ///
    /// - Parameter fringe: The queue that defines the searching strategy.
    ///
    /// - Returns: The solution to the search problem. If no path can be found,
    ///   `nil` is returned.
    public func solve(
        with fringe: @autoclosure () -> any Queue<Node>
    ) -> Solution? {
        let node = Node(
            state: initialState,
            accumulatedCost: monoid.id
        )
        if isGoal(node.state) {
            return buildSolution(node)
        }
        var seen = Set<State>()
        seen.insert(node.state)
        var fringe = fringe()
        fringe.enqueue(node)
        while !fringe.isEmpty {
            let top = fringe.dequeue()!
            seen.insert(node.state)
            for action in actions(top.state) {
                let newState = transition(top.state, action)
                let newCost = cost(top.state, action)
                let newNode = Node(
                    state: newState,
                    actionTaken: action,
                    accumulatedCost: monoid.op(top.accumulatedCost, newCost),
                    previous: top
                )
                if !seen.contains(newState) {
                    if isGoal(newState) {
                        return buildSolution(newNode)
                    }
                    fringe.enqueue(newNode)
                }
            }
        }
        return nil
    }
    
    func buildSolution(_ node: Node) -> Solution {
        var states: [State]  = []
        var actions: [Action] = []
        var current: Node? = node
        while current != nil {
            states.insert(current!.state, at: 0)
            if let action = current!.actionTaken {
                actions.insert(action, at: 0)
            }
            current = current!.previous
        }
        return Solution(
            states: states,
            actions: actions,
            cost: node.accumulatedCost
        )
    }
}
