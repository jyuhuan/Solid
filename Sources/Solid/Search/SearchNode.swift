/// Represents a path explored by a search algorithm.
public class SearchNode<State, Action, Cost> {
    public let state: State
    public let actionTaken: Action?
    public let accumulatedCost: Cost
    public let previous: SearchNode?
    
    public init(
        state: State,
        actionTaken: Action? = nil,
        accumulatedCost: Cost,
        previous: SearchNode? = nil
    ) {
        self.state = state
        self.actionTaken = actionTaken
        self.accumulatedCost = accumulatedCost
        self.previous = previous
    }
}
