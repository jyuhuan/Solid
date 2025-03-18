/// A type that solves a search problem.
public protocol Searcher<State, Action, Cost> {
    
    associatedtype State
    associatedtype Action
    associatedtype Cost

    /// Finds the solution to the given search problem.
    /// 
    /// - Parameter searchProblem: The search problem to solve.
    ///
    /// - Returns: The solution to the search problem. If no path can be found,
    ///   `nil` is returned.
    func solve(
        _ searchProblem: SearchProblem<State, Action, Cost>
    ) -> SearchProblemSolution<State, Action, Cost>?
}
