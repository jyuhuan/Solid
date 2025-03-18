# ``Solid/Graph``

## Topics

### Associated types
- ``Graph/Vertex``
- ``Graph/Weight``

### Vertex and edge queries
- ``vertices``
- ``outgoingVertices(from:)``
- ``weight(from:to:)``

### Lazy transformation
- ``map(_:)``

### Breadth-first search
- ``breadthFirstSearch(from:to:)``
- ``breadthFirstSearch(from:to:using:)``
- ``breadthFirstSearch(from:to:with:)``
- ``breadthFirstSearch(from:to:using:with:)``

### Depth-first search
- ``depthFirstSearch(from:to:)``
- ``depthFirstSearch(from:to:using:)``
- ``depthFirstSearch(from:to:with:)``
- ``depthFirstSearch(from:to:using:with:)``

### Dijkstra's algorithm search
- ``dijkstrasAlgorithmSearch(from:to:)``
- ``dijkstrasAlgorithmSearch(from:to:using:)``
- ``dijkstrasAlgorithmSearch(from:to:with:)``
- ``dijkstrasAlgorithmSearch(from:to:using:with:)``

### A\* search
- ``aStarSearch(from:to:heuristic:)``
- ``aStarSearch(from:to:using:heuristic:)``
- ``aStarSearch(from:to:heuristic:priorityQueue:)``
- ``aStarSearch(from:to:using:heuristic:priorityQueue:)``

### Floyed-Warshall algorithm
- ``shortestPaths()``
- ``transitiveClosure()``
- ``runFloydWarshallAlgorithm(semiring:)``
- ``FloydWarshallAlgorithmResult``
