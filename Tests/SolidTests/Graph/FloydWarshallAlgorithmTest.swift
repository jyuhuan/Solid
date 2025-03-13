import Testing

@testable import Solid

struct FloydWarshallAlgorithmTest {
    
    let graph = AdjacencyListGraph(
        [
            "1": ["3": -2.0],
            "2": ["1": 4.0, "3": 3.0],
            "3": [:],
            "4": ["2": -1.0],
        ]
    )

    @Test func testShortestPaths() async throws {
        
        let result = graph.shortestPaths()
                
        #expect(result.weights.count == 16)
        
        #expect(result.weight(from: "1", to: "1") == 0.0)
        #expect(result.path(from: "1", to: "1") == ["1"])
        
        #expect(result.weight(from: "1", to: "2") == .infinity)
        #expect(result.path(from: "1", to: "2") == nil)
        
        #expect(result.weight(from: "1", to: "3") == -2.0)
        #expect(result.path(from: "1", to: "3") == ["1", "3"])
        
        #expect(result.weight(from: "1", to: "4") == .infinity)
        #expect(result.path(from: "1", to: "4") == nil)

        #expect(result.weight(from: "2", to: "1") == 4.0)
        #expect(result.path(from: "2", to: "1") == ["2", "1"])

        #expect(result.weight(from: "2", to: "2") == 0.0)
        #expect(result.path(from: "2", to: "2") == ["2"])
        
        #expect(result.weight(from: "2", to: "3") == 2.0)
        #expect(result.path(from: "2", to: "3") == ["2", "1", "3"])
        
        #expect(result.weight(from: "2", to: "4") == .infinity)
        #expect(result.path(from: "2", to: "4") == nil)
        
        #expect(result.weight(from: "3", to: "1") == .infinity)
        #expect(result.path(from: "3", to: "1") == nil)
        
        #expect(result.weight(from: "3", to: "2") == .infinity)
        #expect(result.path(from: "3", to: "2") == nil)
        
        #expect(result.weight(from: "3", to: "3") == 0.0)
        #expect(result.path(from: "3", to: "3") == ["3"])
        
        #expect(result.weight(from: "3", to: "4") == .infinity)
        #expect(result.path(from: "3", to: "4") == nil)
        
        #expect(result.weight(from: "4", to: "1") == 3.0)
        #expect(result.path(from: "4", to: "1") == ["4", "2", "1"])
        
        #expect(result.weight(from: "4", to: "2") == -1.0)
        #expect(result.path(from: "4", to: "2") == ["4", "2"])
        
        #expect(result.weight(from: "4", to: "3") == 1.0)
        #expect(result.path(from: "4", to: "3") == ["4", "2", "1", "3"])
        
        #expect(result.weight(from: "4", to: "4") == 0.0)
        #expect(result.path(from: "4", to: "4") == ["4"])
    }
    
    @Test func testTransitiveClosure() async throws {                
        let result = graph.transitiveClosure()
                
        #expect(result.weights.count == 16)
        
        #expect(result.weight(from: "1", to: "1") == true)
        #expect(result.path(from: "1", to: "1") == ["1"])
        
        #expect(result.weight(from: "1", to: "2") == false)
        #expect(result.path(from: "1", to: "2") == nil)
        
        #expect(result.weight(from: "1", to: "3") == true)
        #expect(result.path(from: "1", to: "3") == ["1", "3"])
        
        #expect(result.weight(from: "1", to: "4") == false)
        #expect(result.path(from: "1", to: "4") == nil)

        #expect(result.weight(from: "2", to: "1") == true)
        #expect(result.path(from: "2", to: "1") == ["2", "1"])

        #expect(result.weight(from: "2", to: "2") == true)
        #expect(result.path(from: "2", to: "2") == ["2"])
        
        #expect(result.weight(from: "2", to: "3") == true)
        #expect(result.path(from: "2", to: "3") == ["2", "1", "3"])
        
        #expect(result.weight(from: "2", to: "4") == false)
        #expect(result.path(from: "2", to: "4") == nil)
        
        #expect(result.weight(from: "3", to: "1") == false)
        #expect(result.path(from: "3", to: "1") == nil)
        
        #expect(result.weight(from: "3", to: "2") == false)
        #expect(result.path(from: "3", to: "2") == nil)
        
        #expect(result.weight(from: "3", to: "3") == true)
        #expect(result.path(from: "3", to: "3") == ["3"])
        
        #expect(result.weight(from: "3", to: "4") == false)
        #expect(result.path(from: "3", to: "4") == nil)
        
        #expect(result.weight(from: "4", to: "1") == true)
        #expect(result.path(from: "4", to: "1") == ["4", "2", "1"])
        
        #expect(result.weight(from: "4", to: "2") == true)
        #expect(result.path(from: "4", to: "2") == ["4", "2"])
        
        #expect(result.weight(from: "4", to: "3") == true)
        #expect(result.path(from: "4", to: "3") == ["4", "2", "1", "3"])
        
        #expect(result.weight(from: "4", to: "4") == true)
        #expect(result.path(from: "4", to: "4") == ["4"])

    }

}
