/// A search problem solver that uses Dijkstra's algorithm.
public struct DijkstrasAlgorithmSearcher<
    State: Hashable,
    Action,
    Cost: Comparable
>: Searcher {
    
    let base: any Searcher<State, Action, Cost>
    
    public init() {
        self.base = GenericSearcher(
            fringe: ArrayBasedPriorityQueue<
                SearchNode<State, Action, Cost>,
                Cost
            > { $0.accumulatedCost }
        )
    }
    
    public init(
        priorityQueue: @escaping @autoclosure () ->
            any PriorityQueue<SearchNode<State, Action, Cost>, Cost>
    ) {
        self.base = GenericSearcher(fringe: priorityQueue())
    }
    
    public func solve(
        _ searchProblem: SearchProblem<State, Action, Cost>
    ) -> SearchProblemSolution<State, Action, Cost>? {
        base.solve(searchProblem)
    }

}

