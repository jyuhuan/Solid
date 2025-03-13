import Testing
@testable import Solid

struct PriorityQueuesTest {
    
    @Test func testArrayBasedPriorityQueue() async throws {
        var q = ArrayBasedPriorityQueue<String, Int>(prioritizedBy: {$0.count})
        #expect(q.isEmpty)
        #expect(q.dequeue() == nil)
        q.enqueue("abcdefgh")
        q.enqueue("abcdefg")
        q.enqueue("abcdef")
        q.enqueue("abcde")
        q.enqueue("abcd")
        q.enqueue("abc")
        q.enqueue("ab")
        q.enqueue("a")
        #expect(!q.isEmpty)
        #expect(q.dequeue() == "a")
        #expect(q.dequeue() == "ab")
        #expect(q.dequeue() == "abc")
        #expect(q.dequeue() == "abcd")
        #expect(q.dequeue() == "abcde")
        #expect(q.dequeue() == "abcdef")
        #expect(q.dequeue() == "abcdefg")
        #expect(q.dequeue() == "abcdefgh")
        #expect(q.isEmpty)
        #expect(q.dequeue() == nil)
    }

}
