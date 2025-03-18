/// A search problem solver that uses depth-first search.
public struct DepthFirstSearcher<State: Hashable, Action, Cost>: Searcher {
    
    let base: any Searcher<State, Action, Cost>
    
    public init() {
        self.base = GenericSearcher(
            fringe: ArrayBasedStack<SearchNode<State, Action, Cost>>()
        )
    }
    
    public init(
        stack: @escaping @autoclosure () ->
            any Stack<SearchNode<State, Action, Cost>>
    ) {
        self.base = GenericSearcher(fringe: stack())
    }
    
    public func solve(
        _ searchProblem: SearchProblem<State, Action, Cost>
    ) -> SearchProblemSolution<State, Action, Cost>? {
        base.solve(searchProblem)
    }
    
}
