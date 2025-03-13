/// A stack backed by an array.
public struct ArrayBasedStack<Element>: Stack {
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
        return elements.removeLast()
    }
}
