/// A search problem solver that uses breadth-first search.
public struct BreadthFirstSearcher<State: Hashable, Action, Cost>: Searcher {
    
    let base: any Searcher<State, Action, Cost>
    
    public init() {
        self.base = GenericSearcher(
            fringe: ArrayBasedFIFOQueue<SearchNode<State, Action, Cost>>()
        )
    }
    
    public init(
        fifoQueue: @escaping @autoclosure () ->
            any FIFOQueue<SearchNode<State, Action, Cost>>
    ) {
        self.base = GenericSearcher(fringe: fifoQueue())
    }
    
    public func solve(
        _ searchProblem: SearchProblem<State, Action, Cost>
    ) -> SearchProblemSolution<State, Action, Cost>? {
        base.solve(searchProblem)
    }
    
}
