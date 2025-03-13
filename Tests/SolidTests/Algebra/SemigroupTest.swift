import Testing

@testable import Solid

struct SemigroupTest {

    @Test func testSemigrouop() async throws {
        let g1: any Semigroup<Int> = newSemigroup(+)
        #expect(g1.op(2, 3) == 5)
        let g2: any Semigroup<Int> = newSemigroup(*)
        #expect(g2.op(2, 3) == 6)
    }
    
    @Test func testAdditiveSemigroup() async throws {
        let g1: any AdditiveSemigroup<Int> = newAdditiveSemigroup(+)
        #expect(g1.add(2, 3) == 5)
        let g2: any Semigroup<Int> = g1.asSemigroup()
        #expect(g2.op(2, 3) == 5)
    }
    
    @Test func testMultiplicativeSemigroup() async throws {
        let g1: any MultiplicativeSemigroup<Int> = newMultiplicativeSemigroup(*)
        #expect(g1.mul(2, 3) == 6)
        let g2: any Semigroup<Int> = g1.asSemigroup()
        #expect(g2.op(2, 3) == 6)
    }

}
