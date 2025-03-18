import Testing
@testable import Solid

struct DijkstrasAlgorithmSearcherTest {

    let problem = makeExampleSearchProblem()

    @Test func testDijkstraSearch() async throws {
        let result = DijkstrasAlgorithmSearcher().solve(problem)!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }
    
    @Test func testDijkstraSearchCustomizedPriorityQueue() async throws {
        let result = DijkstrasAlgorithmSearcher(
            priorityQueue: ArrayBasedPriorityQueue(
                prioritizedBy: { $0.accumulatedCost }
            )
        ).solve(problem)!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }

}
