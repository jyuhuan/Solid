extension SearchProblem {
    
    /// Represents a path explored by a search algorithm.
    public class Node {
        public let state: State
        public let actionTaken: Action?
        public let accumulatedCost: Cost
        public let previous: Node?
        
        public init(
            state: State,
            actionTaken: Action? = nil,
            accumulatedCost: Cost,
            previous: Node? = nil
        ) {
            self.state = state
            self.actionTaken = actionTaken
            self.accumulatedCost = accumulatedCost
            self.previous = previous
        }
    }

}
