import Testing
@testable import Solid


struct BloomFilterTest {
    
    @Test func testBloomFilter() async throws {
        let hashFunc1: (String) -> Int = { ["x": 0, "y": 1, "z": 2][$0]! }
        let hashFunc2: (String) -> Int = { ["x": 1, "y": 2, "z": 3][$0]! }
        var bf = BloomFilter<String>(cellCount: 4, hashFunctions: [hashFunc1, hashFunc2])
        bf.add("x")
        bf.add("y")
        #expect(bf.mayHave("x"))
        #expect(bf.mayHave("y"))
        #expect(bf.doesNotHave("z"))
    }
    
    @Test func testInitializingWithDefaultHashFunctions() async throws {
        let bf = BloomFilter<String>(cellCount: 4)
        #expect(bf.base.hashFunctions.count == 3)
    }
    
}
