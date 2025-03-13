import Testing
@testable import Solid

struct MagmaTest {

    @Test func testMagma() async throws {
        let magma: any Magma<Int> = newMagma(+)
        #expect(magma.op(1, 2) == 3)
        
        let additiveMagma: any AdditiveMagma<Int> = newAdditiveMagma(+)
        #expect(additiveMagma.add(1, 2) == 3)
        
        let multiplicativeMagma: any MultiplicativeMagma<Int> = newMultiplicativeMagma(*)
        #expect(multiplicativeMagma.mul(1, 2) == 2)
    }
    
    @Test func testMagmaConversions() async throws {
        let additiveMagma: any AdditiveMagma<Int> = newAdditiveMagma(+)
        let magma1: any Magma<Int> = additiveMagma.asMagma()
        #expect(magma1.op(1, 2) == 3)
        
        let multiplicativeMagma: any MultiplicativeMagma<Int> = newMultiplicativeMagma(*)
        let magma2: any Magma<Int> = multiplicativeMagma.asMagma()
        #expect(magma2.op(1, 2) == 2)
    }

}
