import Testing
@testable import Solid

struct AStarSearcherTest {

    let problem = makeExampleSearchProblem()
    
    @Test func testAStarSearch() async throws {
        let result = AStarSearcher(
            heuristic: { state in
                [
                    "a": 2,
                    "b": 1,
                    "c": 1,
                    "d": 0,
                ][state]!
            }
        ).solve(problem)!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }
    
    @Test func testAStarSearchCustomizedPriorityQueue() async throws {
        let result = AStarSearcher(
            heuristic: { state in
                [
                    "a": 2,
                    "b": 1,
                    "c": 1,
                    "d": 0,
                ][state]!
            },
            priorityQueue: { heuristic in
                ArrayBasedPriorityQueue(
                    prioritizedBy: { node in
                        node.accumulatedCost + heuristic(node.state)
                    }
                )
            }
        ).solve(problem)!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }


}
