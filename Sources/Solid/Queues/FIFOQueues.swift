/// A FIFO queue backed by an array.
public struct ArrayBasedFIFOQueue<Element>: FIFOQueue {
    private var elements: [Element]

    public init() {
        self.elements = []
    }
    
    public var isEmpty: Bool { elements.isEmpty }

    public mutating func enqueue(_ element: Element) {
        elements.append(element)
    }
    
    public mutating func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }
        return elements.removeFirst()
    }
}
