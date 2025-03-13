/// A memory-efficient data structure for approximate frequency counting.
///
/// ### Creating an instance
///
/// To create a count-min sketch, use ``init(cellCount:)``, and specify the
/// number of cells. The higher the number of cells, the more accurate the
/// counts will be, at the expense of higher memory usage:
///
/// ```swift
/// var sketch = CountMinSketch<String>(cellCount: 10)
/// ```
///
/// To specify your own hash functions, use ``init(cellCount:hashFunctions:)``:
///
/// ```swift
/// var sketch = CountMinSketch<String>(cellCount: 4, hashFunctions: /*...*/)
/// ```
/// ### Adding count to an element
///
/// Use ``count(_:for:)`` to add the count for an element to the count-min
/// sketch:
///
/// ```swift
/// sketch.count(3, for "x")
/// ```
///
/// ### Estimating accumulated count of an element
///
/// To query the estimated count for an element, use ``estimatedCount(for:)``:
///
/// ```swift
/// // Returns a count that might be higher than actual
/// sketch.estimatedCount(for: "x")
/// ```
public struct CountMinSketch<Element: Hashable>: ApproximateAccumulator {
    var base: HashBasedApproximateAccumulator<Element, Int>
    
    /// Creates a count-min sketch.
    ///
    /// - Parameters cellCount: The number of cells to allocate for each hash
    ///   function.
    public init(cellCount: Int) {
        self.init(
            cellCount: cellCount,
            hashFunctions: defaultHashFunctions(size: cellCount)
        )
    }
    
    /// Creates a count-min sketch with the specified hash functions.
    ///
    /// - Parameters:
    ///   - cellCount: The number of cells to allocate for each hash function.
    ///   - hashFunctions: The has functions to use.
    public init(cellCount: Int, hashFunctions: [(Element) -> Int]) {
        base = HashBasedApproximateAccumulator(
            cellCount: cellCount,
            hashFunctions: hashFunctions,
            updateMonoid: newMonoid(id: 0, op: +),
            queryMonoid: newMonoid(id: Value.max, op: min)
        )
    }
    
    public mutating func collect(value: Int, for key: Element) {
        guard value >= 0 else { return }
        base.collect(value: value, for: key)
    }
    
    /// Adds a specified count to an element.
    /// - Parameters:
    ///   - number: The count to be added.
    ///   - element: The element to add the count to.
    public mutating func count(_ number: Int, for element: Element) {
        collect(value: number, for: element)
    }
    
    public func value(for key: Element) -> Int {
        base.value(for: key)
    }
    
    /// Estimates the accumulated count for the given element.
    /// - Parameter element: The element to estimate
    /// - Returns: The estimated count, which might be higher than actual.
    public func estimatedCount(for element: Element) -> Int {
        value(for: element)
    }

}
