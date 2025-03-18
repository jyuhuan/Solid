import Testing
@testable import Solid

struct DepthFirstSearcherTest {

    let problem = makeExampleSearchProblem()
    
    @Test func testDepthFirstSearch() async throws {
        let result = DepthFirstSearcher().solve(problem)!
        #expect(result.states == ["a", "c", "d"])
        #expect(result.actions == ["c", "d"])
        #expect(result.cost == 23)
    }
    
    @Test func testDepthFirstSearchCustomizedStack() async throws {
        let result = DepthFirstSearcher(stack: ArrayBasedStack()).solve(problem)!
        #expect(result.states == ["a", "c", "d"])
        #expect(result.actions == ["c", "d"])
        #expect(result.cost == 23)
    }

}
