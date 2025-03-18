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

### Path searching
- ``path(from:to:searcher:)``
- ``path(from:to:searcher:monoid:)``

### Floyed-Warshall algorithm
- ``shortestPaths()``
- ``transitiveClosure()``
- ``runFloydWarshallAlgorithm(semiring:)``
- ``FloydWarshallAlgorithmResult``
