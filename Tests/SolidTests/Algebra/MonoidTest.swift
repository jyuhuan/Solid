import Testing
@testable import Solid

struct MonoidTest {

    @Test func testMonoid() async throws {
        let m1: any Monoid<Int> = newMonoid(id: 0, op: +)
        #expect(m1.op(2, 3) == 5)
        let m2: any Monoid<Int> = newMonoid(id: 1, op: *)
        #expect(m2.op(2, 3) == 6)
    }
    
    @Test func testAdditiveMonoid() async throws {
        let m1: any AdditiveMonoid<Int> = newAdditiveMonoid(zero: 0, add: +)
        #expect(m1.add(2, 3) == 5)
        let m2: any Monoid<Int> = m1.asMonoid()
        #expect(m2.op(2, 3) == 5)
    }
    
    @Test func testMultiplicativeMonoid() async throws {
        let m1: any MultiplicativeMonoid<Int> = newMultiplicativeMonoid(one: 1, mul: *)
        #expect(m1.mul(2, 3) == 6)
        let m2: any Monoid<Int> = m1.asMonoid()
        #expect(m2.op(2, 3) == 6)
    }

}
