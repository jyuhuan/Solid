import Testing
@testable import Solid

struct SemiringTest {
    
    @Test func testSemiringConstructionUsingClosures() async throws {
        let r: any Semiring<Int> = newSemiring(zero: 0, one: 1, add: +, mul: *)
        #expect(r.zero == 0)
        #expect(r.one == 1)
        #expect(r.add(2, 3) == 5)
        #expect(r.mul(2, 3) == 6)
    }

}
