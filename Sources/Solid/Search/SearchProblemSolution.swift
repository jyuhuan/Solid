extension SearchProblem {
    
    /// The solution to a search problem.
    public struct Solution {
        
        /// The states in the path found.
        /// The first element is always the initial state.
        /// The last element is always the goal state.
        public let states: [State]
        
        /// The actions taken to transition from the initial state to the goal
        /// state.
        public let actions: [Action]
        
        /// The total cost of the path found.
        public let cost: Cost
    }

}

