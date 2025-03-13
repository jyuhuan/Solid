/// A data structure that accumulates values approximately by hashing the keys.
public struct HashBasedApproximateAccumulator<
    Key: Hashable,
    Value
>: ApproximateAccumulator {
    var cells: [[Value]]
    let hashFunctions: any RandomAccessCollection<(Key) -> Int>
    let updateMonoid: any Monoid<Value>
    let queryMonoid: any Monoid<Value>
    
    /// Creates a hash-based approximate accumulator.
    /// - Parameters:
    ///   - cellCount: The number of cells to allocate to each hash function.
    ///   - hashFunctions: The hash functions to use. 
    ///   - updateMonoid: The monoid for value updates.
    ///   - queryMonoid: The monoid for value aggregation at query time.
    public init(
        cellCount: Int,
        hashFunctions: [(Key) -> Int],
        updateMonoid: any Monoid<Value>,
        queryMonoid: any Monoid<Value>
    ) {
        precondition(
            cellCount > 0,
            "Cell count for HashBasedApproximateAccumulator must be positive!"
        )
        precondition(
            !hashFunctions.isEmpty,
            "At least one hash function must be provided!"
        )
        self.cells = [[Value]](
            repeating: [Value](
                repeating: updateMonoid.id,
                count: cellCount
            ),
            count: hashFunctions.count
        )
        self.updateMonoid = updateMonoid
        self.queryMonoid = queryMonoid
        self.hashFunctions = hashFunctions
    }
    
    public mutating func collect(value: Value, for key: Key) {
        var index: Int = 0
        for f in hashFunctions {
            cells[index][f(key)] = updateMonoid.op(cells[index][f(key)], value)
            index += 1
        }
    }
    
    public func value(for key: Key) -> Value {
        var result = queryMonoid.id
        var index: Int = 0
        for f in hashFunctions {
            let hash = f(key)
            let cellValue = cells[index][hash]
            result = queryMonoid.op(result, cellValue)
            index += 1
        }
        return result
    }
}


func defaultHashFunctions<Key: Hashable>(
    size: Int,
    numOfHashFunctions: Int = 3
) -> [(Key) -> Int] {
    (0 ..< numOfHashFunctions).map { index in
        { key in
            var hasher = Hasher()
            hasher.combine(index)
            hasher.combine(key)
            let hash: Int = hasher.finalize()
            return abs(hash) % size
        }
    }
}
