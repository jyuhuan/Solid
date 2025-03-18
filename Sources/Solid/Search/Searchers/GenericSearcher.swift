/// A search problem solver whose traversal order can be customized by a queue.
public struct GenericSearcher<State: Hashable, Action, Cost>: Searcher {
        
    let fringeFactory: () -> any Queue<SearchNode<State, Action, Cost>>
    
    public init(
        fringe: @escaping @autoclosure () ->
            any Queue<SearchNode<State, Action, Cost>>
    ) {
        self.fringeFactory = fringe
    }
    
    public func solve(
        _ problem: SearchProblem<State, Action, Cost>
    ) -> SearchProblemSolution<State, Action, Cost>? {
        let node = SearchNode<State, Action, Cost>(
            state: problem.initialState,
            accumulatedCost: problem.monoid.id
        )
        var seen = Set<State>()
        var fringe = fringeFactory()
        fringe.enqueue(node)
        while !fringe.isEmpty {
            let top = fringe.dequeue()!
            if problem.isGoal(top.state) {
                return buildSolution(top)
            }
            seen.insert(top.state)
            for action in problem.actions(top.state) {
                let newState = problem.transition(top.state, action)
                let newCost = problem.cost(top.state, action)
                let newNode = SearchNode<State, Action, Cost>(
                    state: newState,
                    actionTaken: action,
                    accumulatedCost: problem.monoid.op(
                        top.accumulatedCost,
                        newCost
                    ),
                    previous: top
                )
                if !seen.contains(newState) {
                    fringe.enqueue(newNode)
                }
            }
        }
        return nil
    }
    
    func buildSolution(
        _ node: SearchNode<State, Action, Cost>
    ) -> SearchProblemSolution<State, Action, Cost>? {
        var states: [State]  = []
        var actions: [Action] = []
        var current: SearchNode<State, Action, Cost>? = node
        while current != nil {
            states.insert(current!.state, at: 0)
            if let action = current!.actionTaken {
                actions.insert(action, at: 0)
            }
            current = current!.previous
        }
        return SearchProblemSolution<State, Action, Cost>(
            states: states,
            actions: actions,
            cost: node.accumulatedCost
        )
    }
}
