@testable import Solid


func makeExampleSearchProblem() -> SearchProblem<String, String, Int> {
    SearchProblem(
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
}
