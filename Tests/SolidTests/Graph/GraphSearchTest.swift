import Testing
@testable import Solid

struct GraphSearchTest {

    let graph = AdjacencyListGraph(
        [
            "A": ["B": 1, "C": 30],
            "B": ["C": 2, "D": 20],
            "C": ["D": 3],
            "D": [:],
        ]
    )
    
    @Test func testDepthFirstSearch() async throws {
        
        let path1 = graph.dijkstrasAlgorithmSearch(from: "A", to: "D")!
        #expect(path1.states == ["A", "B", "C", "D"])
        #expect(path1.cost == 6)
        
        let path2 = graph.aStarSearch(
            from: "A",
            to: "D",
            heuristic: { ["A": 2, "B": 1, "C": 1, "D": 0][$0]! }
        )!
        #expect(path2.states == ["A", "B", "C", "D"])
        #expect(path2.cost == 6)
    }

}
