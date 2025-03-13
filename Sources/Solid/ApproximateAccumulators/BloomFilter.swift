/// A data structure that can determine if an element is possibly present or
/// definitely absent.
///
/// ### Creating an instance
///
/// To create a bloom filter, use ``init(cellCount:)``, and specify the number
/// of cells. The higher the number of cells, the more accurate the bloom
/// filter's "may have" answer will be, at the expense of higher memory usage:
///
/// ```swift
/// var bf = BloomFilter<String>(cellCount: 10)
/// ```
///
/// To specify your own hash functions, use ``init(cellCount:hashFunctions:)``:
///
/// ```swift
/// var bf = BloomFilter<String>(cellCount: 4, hashFunctions: /*...*/)
/// ```
/// ### Adding an element
///
/// Use ``add(_:)`` to add an element to the bloom filter:
///
/// ```swift
/// bf.add("x")
/// ```
///
/// ### Checking existence of an element
///
/// When querying the existence of an element, choose the verb that matches your
/// intention.
///
/// To test if an element is possibly in the bloom filter, use
/// ``mayHave(_:)``:
///
///   ```swift
///   bf.mayHave("x")
///   ```
///
/// To test if an element is definitely not in the bloom filter, use
/// ``doesNotHave(_:)``:
///
/// ```swift
/// bf.doesNotHave("y")
/// ```
public struct BloomFilter<Element: Hashable>: ApproximateAccumulator {
    var base: HashBasedApproximateAccumulator<Element, Bool>
    
    /// Creates a bloom filter.
    ///
    /// - Parameter cellCount: The number of cells to allocate for each hash
    ///   function.
    public init(cellCount: Int) {
        self.init(
            cellCount: cellCount,
            hashFunctions: defaultHashFunctions(size: cellCount)
        )
    }
    
    /// Creates a bloom filter using the specified hash functions.
    ///
    /// - Parameters:
    ///   - cellCount: The number of cells to allocate for each hash function.
    ///   - hashFunctions: The has functions to use.
    public init(cellCount: Int, hashFunctions: [(Element) -> Int]) {
        self.base = HashBasedApproximateAccumulator(
            cellCount: cellCount,
            hashFunctions: hashFunctions,
            updateMonoid: newMonoid(id: false, op: { $0 || $1 }),
            queryMonoid: newMonoid(id: true, op: { $0 && $1 })
        )
    }
    
    public mutating func collect(value: Bool, for key: Element) {
        base.collect(value: value, for: key)
    }
    
    /// Adds an element to this bloom filter.
    /// - Parameter element: The element to be added.
    public mutating func add(_ element: Element) {
        collect(value: true, for: element)
    }
    
    public func value(for key: Element) -> Bool {
        base.value(for: key)
    }
    
    /// Tests whether the given element is possibly in this bloom filter.
    /// - Parameter element: The element whose potential presence is being
    ///   tested.
    /// - Returns: True if the element is possibly in this bloom filter.
    ///   False if the element is definitely not in this bloom filter.
    public func mayHave(_ element: Element) -> Bool {
        value(for: element)
    }
    
    /// Tests whether the given element is definitely not in this bloom filter.
    /// - Parameter element: The element whose definite absence is being tested.
    /// - Returns: True if the element is definitely not in this bloom filter.
    ///   False if the element is possibly in this bloom filter.
    public func doesNotHave(_ element: Element) -> Bool {
        !mayHave(element)
    }
}

