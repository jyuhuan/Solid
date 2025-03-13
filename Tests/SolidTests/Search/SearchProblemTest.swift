import Testing
@testable import Solid

struct SearchProblemTest {
    
    let problem: SearchProblem = SearchProblem(
        initialState: "a",
        isGoal: { $0 == "d" },
        actions: { state in
            [
                "a": ["b", "c"],
                "b": ["d"],
                "c": ["d"]
            ][state]!
        },
        transition: { state, action in
            action
        },
        cost: { state, action in
            [
                Pair("a", "b"): 1,
                Pair("a", "c"): 11,
                Pair("b", "d"): 2,
                Pair("c", "d"): 12,
            ][Pair(state, action)]!
        }
    )

    
    @Test func testDepthFirstSearch() async throws {
        let result = problem.solveUsingDepthFirstSearch()!
        #expect(result.states == ["a", "c", "d"])
        #expect(result.actions == ["c", "d"])
        #expect(result.cost == 23)
    }
    
    @Test func testDepthFirstSearchCustomizedStack() async throws {
        let result = problem.solveUsingDepthFirstSearch(with: ArrayBasedStack())!
        #expect(result.states == ["a", "c", "d"])
        #expect(result.actions == ["c", "d"])
        #expect(result.cost == 23)
    }

    @Test func testBreadthFirstSearch() async throws {
        let result = problem.solveUsingBreadthFirstSearch()!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }
    
    @Test func testBreadthFirstSearchCustomizedFIFOQueue() async throws {
        let result = problem.solveUsingBreadthFirstSearch(with: ArrayBasedFIFOQueue())!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }
    
    @Test func testDijkstraSearch() async throws {
        let result = problem.solveUsingDijkstrasAlgorithm()!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }
    
    @Test func testDijkstraSearchCustomizedPriorityQueue() async throws {
        let result = problem.solveUsingDijkstrasAlgorithm(
            with: ArrayBasedPriorityQueue(prioritizedBy: { $0.accumulatedCost })
        )!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }
    
    @Test func testAStarSearch() async throws {
        let result = problem.solveUsingAStarSearch(
            heuristic: { state in
                [
                    "a": 2,
                    "b": 1,
                    "c": 1,
                    "d": 0,
                ][state]!
            }
        )!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }
    
    @Test func testAStarSearchCustomizedPriorityQueue() async throws {
        let result = problem.solveUsingAStarSearch(
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
        )!
        #expect(result.states == ["a", "b", "d"])
        #expect(result.actions == ["b", "d"])
        #expect(result.cost == 3)
    }

}
