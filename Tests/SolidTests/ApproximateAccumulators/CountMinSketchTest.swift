import Testing
@testable import Solid


struct CountMinSketchTest {

    @Test func testCountMinSketch() async throws {
        let hashFunc1: (String) -> Int = { ["x": 0, "y": 1, "z": 2][$0]! }
        let hashFunc2: (String) -> Int = { ["x": 1, "y": 2, "z": 3][$0]! }
        var cms = CountMinSketch<String>(cellCount: 4, hashFunctions: [hashFunc1, hashFunc2])
        cms.count(1, for: "x")
        cms.count(2, for: "x")
        cms.count(3, for: "x")
        cms.count(1, for: "y")
        cms.count(1, for: "y")
        cms.count(-1, for: "x")  // Negative counts are expected to be ignored
        cms.count(-1, for: "y")  // Negative counts are expected to be ignored
        #expect(cms.estimatedCount(for: "x") == 6)
        #expect(cms.estimatedCount(for: "y") == 2)
        #expect(cms.estimatedCount(for: "z") == 0)
    }
    
    @Test func testInitializingWithDefaultHashFunctions() async throws {
        let cms = CountMinSketch<String>(cellCount: 4)
        #expect(cms.base.hashFunctions.count == 3)
    }

}
