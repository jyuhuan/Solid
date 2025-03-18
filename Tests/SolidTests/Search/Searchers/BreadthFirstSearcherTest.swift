import Testing
@testable import Solid

struct BreadthFirstSearcherTest {

    let problem = makeExampleSearchProblem()
    
    @Test func testBreadthFirstSearch() async throws {
        let result = BreadthFirstSearcher().solve(problem)!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }
    
    @Test func testBreadthFirstSearchCustomizedFIFOQueue() async throws {
        let result = BreadthFirstSearcher(
            fifoQueue: ArrayBasedFIFOQueue()
        ).solve(problem)!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }

}
