import Testing
@testable import Solid

struct GraphSearchTest {

    let graph: any Graph<String, Int> = AdjacencyListGraph<String, Int>(
        [
            "A": ["B": 1, "C": 30],
            "B": ["C": 2, "D": 20],
            "C": ["D": 3],
            "D": [:],
        ]
    )
    
    @Test func testDepthFirstSearch() async throws {
                
        let path1 = graph.path(from: "A", to: "D", searcher: DijkstrasAlgorithmSearcher())!
        #expect(path1.states == ["A", "B", "C", "D"])
        #expect(path1.cost == 6)
        
        let path2 = graph.path(
            from: "A",
            to: "D",
            searcher: AStarSearcher(
                heuristic: { ["A": 2, "B": 1, "C": 1, "D": 0][$0]! }
            )
        )!
        #expect(path2.states == ["A", "B", "C", "D"])
        #expect(path2.cost == 6)
    }

}
