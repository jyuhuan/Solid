/// An algebraic structure with an associative binary operation.
///
/// A semigroup is an algebraic structure consisting of:
/// - a type: `T`, and
/// - an associative binary operation: `(T, T) -> T`.
///
/// In short, a semigroup is an associative ``Magma``.
///
/// ### Mathematical requirements
///
/// - **Closure property**. The result of the binary operation must also be a
///   member of the semigroup's type. This is automatically satisfied by the
///   fact that the operands (input) and the return value (output) of the
///   ``Magma/op(_:_:)`` method have the same type, ``Magma/T``.
///
/// - **Associative operation**. The binary operation in a semigroup must be
///   associative. For example, for integers, `+` is associative, while `-` is
///   not:
///
///   ```
///   (1 + 2) + 3 == 1 + (2 + 3)
///   (1 - 2) - 3 != 1 - (2 - 3)
///   ```
///
/// ### Creating an instance
///
/// For most use cases, call the factory function ``newSemigroup(_:)`` to create
/// a simple instance.
///
/// ```swift
/// let semigroup: any Semigroup<Int> = newSemigroup(+)
/// ```
///
/// You can also create your own type that conforms to the `Semigroup` protocol
/// and implement the `op` method.
///
/// ### Variants
///
/// If you need to emphasize the semantics of the semigroup's operation, use
/// ``AdditiveSemigroup`` or ``MultiplicativeSemigroup``.
public protocol Semigroup<T>: Magma {}


/// A semigroup whose operation has the semantics of addition.
///
/// To properly implement a semigroup, your binary operation must be
/// associative. For example, for integers, `+` is associative, while `-` is not:
///
/// ```
/// (1 + 2) + 3 == 1 + (2 + 3)
/// (1 - 2) - 3 != 1 - (2 - 3)
/// ```
public protocol AdditiveSemigroup<T>: AdditiveMagma {}
extension AdditiveSemigroup {
    
    /// Adapts this additive semigroup to be a semigroup whose operation has no
    /// specific semantics.
    ///
    /// - Returns: A semigroup with the same behavior, only adapted to conform
    ///   to the ordinary ``Semigroup`` protocol.
    public func asSemigroup() -> some Semigroup<T> {
        AnySemigroup(self.add)
    }
}


/// A semigroup whose operation has the semantics of multiplication.
///
/// To properly implement a semigroup, your binary operation must be
/// associative. For example, for real numbers, `*` is associative, while `/` is
/// not:
///
/// ```
/// (1 * 2) * 3 == 1 * (2 * 3)
/// (1 / 2) / 3 != 1 / (2 / 3)
/// ```
public protocol MultiplicativeSemigroup<T>: MultiplicativeMagma { }
extension MultiplicativeSemigroup {

    /// Adapts this multiplicative semigroup to be a semigroup whose operation
    /// has no specific semantics.
    ///
    /// - Returns: A semigroup with the same behavior, only adapted to conform
    ///   to the ordinary ``Semigroup`` protocol.
    public func asSemigroup() -> some Semigroup<T> {
        AnySemigroup(self.mul)
    }
}


// MARK: Factory Functions

/// Creates a new semigroup from a binary operation.
///
/// Example:
///
/// ```swift
/// let semigroup: any Semigroup<Int> = newSemigroup(+)
/// ```
///
/// - Parameter op: The binary operation. Must be associative.
///
/// - Returns: A new semigroup with the specified binary operation.
public func newSemigroup(
    _ op: @escaping (Int, Int) -> Int
) -> any Semigroup<Int> {
    AnySemigroup(op)
}

/// Creates a new additive semigroup from an addition operation.
///
/// Example:
///
/// ```swift
/// let semigroup: any AdditiveSemigroup<Int> = newAdditiveSemigroup(+)
/// ```
///
/// - Parameter add: The addition operation. Must be associative.
///
/// - Returns: A new semigroup with the specified addition operation.
public func newAdditiveSemigroup(
    _ add: @escaping (Int, Int) -> Int
) -> any AdditiveSemigroup<Int> {
    AnyAdditiveSemigroup(add)
}

/// Creates a new multiplicative semigroup from a multiplication operation.
///
/// Example:
///
/// ```swift
/// let semigroup: any MultiplicativeSemigroup<Int> = newMultiplicativeSemigroup(+)
/// ```
///
/// - Parameter mul: The multiplication operation. Must be associative.
/// 
/// - Returns: A new semigroup with the specified multiplication operation.
public func newMultiplicativeSemigroup(
    _ mul: @escaping (Int, Int) -> Int
) -> any MultiplicativeSemigroup<Int> {
    AnyMultiplicativeSemigroup(mul)
}


// MARK: Concrete Implementations

struct AnySemigroup<T>: Semigroup {
    private let _op: (T, T) -> T

    init(_ op: @escaping (T, T) -> T) {
        self._op = op
    }

    func op(_ t1: T, _ t2: T) -> T {
        return _op(t1, t2)
    }
}

struct AnyAdditiveSemigroup<T>: AdditiveSemigroup {
    private let _add: (T, T) -> T
    init(_ add: @escaping (T, T) -> T) {
        self._add = add
    }
    func add(_ t1: T, _ t2: T) -> T {
        self._add(t1, t2)
    }
}

struct AnyMultiplicativeSemigroup<T>: MultiplicativeSemigroup {
    private let _mul: (T, T) -> T
    init(_ mul: @escaping (T, T) -> T) {
        self._mul = mul
    }
    func mul(_ t1: T, _ t2: T) -> T {
        self._mul(t1, t2)
    }
}
