/// A data structure that approximately accumulates values associated with keys.
public protocol ApproximateAccumulator<Key, Value> {
    
    /// The type of the keys whose values are to be accumulated.
    associatedtype Key
    
    /// The type of the values to be accumulated.
    associatedtype Value
    
    /// Collects the specified value for the given key.
    /// - Parameters:
    ///   - value: The value to be collected.
    ///   - key: The key that the value should be accumulated for.
    mutating func collect(value: Value, for key: Key)
    
    /// Returns the accumulated value for the given key.
    /// - Parameter key: The key to retrieve the accumulated value for.
    func value(for key: Key) -> Value
}
