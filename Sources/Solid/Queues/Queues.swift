/// A collection with a specific order for adding and removing elements.
public protocol Queue<Element> {
    
    /// The type of the elements in the queue.
    associatedtype Element
    
    /// Returns whether the queue is empty.
    var isEmpty: Bool { get }
    
    /// Places an element into the queue.
    /// - Parameter element: The element to be placed into the queue.
    mutating func enqueue(_ element: Element)
    
    /// Removes an element from the queue.
    ///
    /// The choice of which element to dequeue is up to the queue's
    /// implementation.
    ///
    /// - Returns: The element removed. `nil` if the queue is empty.
    mutating func dequeue() -> Element?
    
    
}


/// A queue where the earliest added element is removed first.
public protocol FIFOQueue<Element>: Queue {}

/// A queue where the latest added element is removed first.
public protocol Stack<Element>: Queue {}

/// A queue where the element with the highest priority is removed first.
public protocol PriorityQueue<Element, Priority>: Queue {
    associatedtype Priority: Comparable
}
