import Testing

@testable import Solid

struct AdjacencyListGraphTest {

    @Test func testAdjacencyListGraph() {
        let graph: any Graph<String, Double> = AdjacencyListGraph(
            [
                "A": ["C": -2.0],
                "B": ["A": 4.0, "C": 3.0],
                "C": [:],
                "D": ["B": -1.0],
            ]
        )
        #expect(graph.vertices == ["A", "B", "C", "D"])
        #expect(graph.outgoingVertices(from: "A") == ["C"])
        #expect(graph.outgoingVertices(from: "B") == ["A", "C"])
        #expect(graph.outgoingVertices(from: "C") == [])
        #expect(graph.outgoingVertices(from: "D") == ["B"])
        #expect(graph.weight(from: "A", to: "C") == -2.0)
        #expect(graph.weight(from: "B", to: "A") == 4.0)
        #expect(graph.weight(from: "B", to: "C") == 3.0)
        #expect(graph.weight(from: "D", to: "B") == -1.0)
    }

}
