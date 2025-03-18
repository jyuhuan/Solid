/// A search problem solver that uses A\* search.
public struct AStarSearcher<
    State: Hashable,
    Action,
    Cost: Comparable
>: Searcher {
    
    let heuristic: (State) -> Cost
    let priorityQueueFactory: (
        (@escaping (State) -> Cost) ->
            any PriorityQueue<SearchNode<State, Action, Cost>, Cost>
    )?
    let isPriorityQueueFactoryProvided: Bool
    
    public init(heuristic: @escaping (State) -> Cost) {
        self.heuristic = heuristic
        self.priorityQueueFactory = nil
        self.isPriorityQueueFactoryProvided = false
    }
    
    public init(
        heuristic: @escaping (State) -> Cost,
        priorityQueue: (
            (@escaping (State) -> Cost) ->
                any PriorityQueue<SearchNode<State, Action, Cost>, Cost>
        )?
    ) {
        self.heuristic = heuristic
        self.priorityQueueFactory = priorityQueue
        self.isPriorityQueueFactoryProvided = true
    }
    
    public func solve(
        _ searchProblem: SearchProblem<State, Action, Cost>
    ) -> SearchProblemSolution<State, Action, Cost>? {
        let fringe = isPriorityQueueFactoryProvided ?
            priorityQueueFactory!(heuristic) :
            ArrayBasedPriorityQueue<SearchNode<State, Action, Cost>, Cost>(
                prioritizedBy: { node in
                    searchProblem.monoid.op(
                        node.accumulatedCost,
                        heuristic(node.state)
                    )
                }
            )
        let base = GenericSearcher(fringe: fringe)
        return base.solve(searchProblem)
    }

}
