import Testing
@testable import Solid

struct FIFOQueuesTest {

    @Test func testArrayBasedFIFOQueue() async throws {
        var q: any Queue<Int> = ArrayBasedFIFOQueue<Int>()
        #expect(q.isEmpty)
        #expect(q.dequeue() == nil)
        q.enqueue(1)
        q.enqueue(2)
        q.enqueue(3)
        q.enqueue(4)
        #expect(!q.isEmpty)
        #expect(q.dequeue() == 1)
        #expect(q.dequeue() == 2)
        #expect(q.dequeue() == 3)
        #expect(q.dequeue() == 4)
        #expect(q.isEmpty)
        #expect(q.dequeue() == nil)
    }
    
}
