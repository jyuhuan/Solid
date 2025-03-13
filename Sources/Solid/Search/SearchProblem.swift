/// Defines a search problem.
///
/// A search problem consists of:
///
/// - **Initial state**. The state that the search should start with.
/// - **Goal predicate**. The predicate that returns true only for goal states.
/// - **Available actions**. The actions available to each possible state.
/// - **State transitions**. The state resulting from applying an action to a
///   state.
/// - **Action costs**. The cost of applying an action in a state.
///
/// Example:
///
/// ```swift
/// let problem = SearchProblem(
///     initialState: "a",
///     isGoal: { $0 == "d" },
///     actions: { state in
///         [
///             "a": ["b", "c"],
///             "b": ["d"],
///             "c": ["d"]
///         ][state]!
///     },
///     transition: { state, action in action },
///     cost: { state, action in
///         [
///             Pair("a", "b"): 1,
///             Pair("a", "c"): 11,
///             Pair("b", "d"): 2,
///             Pair("c", "d"): 12,
///         ][Pair(state, action)]!
///     }
/// )
/// let solution = problem.solveUsingDepthFirstSearch()
/// ```
///
/// ### Choosing a traversal order
///
/// Use one of the `solve` methods to solve an instance of `SearchProblem`:
///
///  - Use ``solveUsingDepthFirstSearch()`` for depth-first search,
///  - Use ``solveUsingBreadthFirstSearch()`` for breadth-first search,
///  - Use ``solveUsingDijkstrasAlgorithm()`` for Dijkstra's algorithm, or
///  - Use ``solveUsingAStarSearch(heuristic:)`` for A\* search.
///
///  If none of these suit your needs, use ``solve(with:)`` and supply a
///  ``Queue`` customized to your requirements.
///
/// ### Customizing cost accumulation
///
/// If you need to modify how the cost for a search path should be accumulated,
/// create an instance using
/// ``init(initialState:isGoal:actions:transition:cost:monoid:)``, which
/// accepts a customized monoid.
///
/// A simplified initializer,
/// ``init(initialState:isGoal:actions:transition:cost:)``, is available for
/// search problems where the cost is a `Numeric` type. In that case, the
/// default monoid (zero, +) will be supplied automatically.
public struct SearchProblem<State: Hashable, Action, Cost> {

    /// The state that the search should start with.
    public let initialState: State
    
    /// Returns true only when the state given is the goal state.
    public let isGoal: (State) -> Bool

    /// The actions available to a given state.
    public let actions: (State) -> [Action]
    
    /// Applies a given action to a given state.
    public let transition: (State, Action) -> State
    
    /// The cost of applying an action to a given state.
    public let cost: (State, Action) -> Cost
    
    /// The monoid that specifies how the cost for a search path should be
    /// accumulated.
    public let monoid: any Monoid<Cost>
    
    /// Creates an instance of a search problem with a customized cost monoid.
    ///
    /// - Parameters:
    ///   - initialState: The state that the search should start with.
    ///   - isGoal: Returns true only when the state given is the goal state.
    ///   - actions: The actions available to a given state.
    ///   - transition: Applies a given action to a given state.
    ///   - cost: The cost of applying an action to a given state.
    ///   - monoid: The monoid that specifies how the cost for a search path
    ///     should be accumulated.
    public init(
        initialState: State,
        isGoal: @escaping (State) -> Bool,
        actions: @escaping (State) -> [Action],
        transition: @escaping (State, Action) -> State,
        cost: @escaping (State, Action) -> Cost,
        monoid: any Monoid<Cost>
    ) {
        self.initialState = initialState
        self.isGoal = isGoal
        self.actions = actions
        self.transition = transition
        self.cost = cost
        self.monoid = monoid
    }
}

extension SearchProblem where Cost: Numeric {
    /// Creates an instance of a search problem.
    ///
    /// - Parameters:
    ///   - initialState: The state that the search should start with.
    ///   - actions: The actions available to a given state.
    ///   - transition: Applies a given action to a given state.
    ///   - isGoal: Returns true only when the state given is the goal state.
    ///   - cost: The cost of applying an action to a given state.
    public init(
        initialState: State,
        isGoal: @escaping (State) -> Bool,
        actions: @escaping (State) -> [Action],
        transition: @escaping (State, Action) -> State,
        cost: @escaping (State, Action) -> Cost
    ) {
        self.init(
            initialState: initialState,
            isGoal: isGoal,
            actions: actions,
            transition: transition,
            cost: cost,
            monoid: newMonoid(id: Cost.zero, op: +)
        )
    }
}
