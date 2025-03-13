# ``Solid/SearchProblem``

## Topics

### Creating an instance
- ``SearchProblem/init(initialState:isGoal:actions:transition:cost:)``
- ``SearchProblem/init(initialState:isGoal:actions:transition:cost:monoid:)``

### Components of a search problem
- ``initialState``
- ``isGoal``
- ``actions``
- ``transition``
- ``cost``
- ``monoid``

### Depth-first search
- ``solveUsingDepthFirstSearch()``
- ``solveUsingDepthFirstSearch(with:)``

### Breadth-first search
- ``solveUsingBreadthFirstSearch()``
- ``solveUsingBreadthFirstSearch(with:)``

### A\* search
- ``solveUsingAStarSearch(heuristic:)``
- ``solveUsingAStarSearch(heuristic:priorityQueue:)``

### Dijkstra's algorithm
- ``solveUsingDijkstrasAlgorithm()``
- ``solveUsingDijkstrasAlgorithm(with:)``

### Customizd search strategy
- ``solve(with:)``

### Utilities
- ``Solution``
- ``Node``
