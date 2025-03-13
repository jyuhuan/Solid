/// A priority queue backed by an array.
public struct ArrayBasedPriorityQueue<Element, Priority: Comparable>: PriorityQueue {
    private var elements: [(Element, Priority)]
    private var extractPriority: (Element) -> Priority

    public init(prioritizedBy extractPriority: @escaping (Element) -> Priority) {
        self.extractPriority = extractPriority
        self.elements = []
    }

    public var isEmpty: Bool { elements.isEmpty }

    public mutating func enqueue(_ element: Element) {
        let priority = extractPriority(element)
        elements.append((element, priority))
        siftUp()
    }
    
    public mutating func dequeue() -> Element? {
        // Case 1: Queue is already empty:
        if elements.isEmpty {
            return nil
        }
        
        // Case 2: Queue only has 1 element left:
        if elements.count == 1 {
            let (element, _) = elements.removeFirst()
            return element
        }
        
        // Case 2: Queue has two elements or more:
        let (rootElement, _) = elements.first!
        let (lastElement, lastPriority) = elements.last!
        elements[0] = (lastElement, lastPriority)
        elements.removeLast()
        siftDown()
        return rootElement
    }
    
    private mutating func siftUp() {
        var currentIndex = elements.count - 1
        while currentIndex != 0 {
            let parentIndex = parent(of: currentIndex)
            let (_, currentPriority) = elements[currentIndex]
            let (_, parentPriority) = elements[parentIndex]
            if currentPriority < parentPriority {
                elements.swapAt(currentIndex, parentIndex)
            }
            currentIndex = parentIndex
        }
    }
    
    private mutating func siftDown() {
        var currentIndex = 0
        while hasLeftChild(currentIndex) || hasRightChild(currentIndex) {
            let (_, currentPriority) = elements[currentIndex]
            var swapPriority: Priority = currentPriority
            var swapIndex: Int = currentIndex
            if hasLeftChild(currentIndex) {
                let leftIndex = leftChild(of: currentIndex)
                let (_, leftPriority) = elements[leftIndex]
                if leftPriority < swapPriority {
                    swapIndex = leftIndex
                    swapPriority = leftPriority
                }
            }
            if hasRightChild(currentIndex) {
                let rightIndex = rightChild(of: currentIndex)
                let (_, rightPriority) = elements[rightIndex]
                if rightPriority < swapPriority {
                    swapIndex = rightIndex
                    swapPriority = rightPriority
                }
            }
            elements.swapAt(currentIndex, swapIndex)
            if currentIndex == swapIndex {
                break
            }
            currentIndex = swapIndex
        }
    }
    
    private func parent(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    private func leftChild(of index: Int) -> Int {
        return 2 * index + 1
    }
    
    private func rightChild(of index: Int) -> Int {
        return leftChild(of: index) + 1
    }
    
    private func isValidIndex(_ index: Int) -> Bool {
        return 0 <= index && index < elements.count
    }
    
    private func hasLeftChild(_ index: Int) -> Bool {
        return isValidIndex(leftChild(of: index))
    }
    
    private func hasRightChild(_ index: Int) -> Bool {
        return isValidIndex(rightChild(of: index))
    }

}
