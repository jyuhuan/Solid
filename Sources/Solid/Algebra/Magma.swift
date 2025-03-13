/// An algebraic structure with a binary operation.
///
/// A magma is an algebraic structure consisting of:
/// - a type: `T`, and
/// - a binary operation: `(T, T) -> T`.
///
/// ### Mathematical requirements
///
/// - **Closure property**. The result of the binary operation must also be a
///   member of the magma's type. This is automatically satisfied by the fact
///   that the operands (input) and the return value (output) of the
///   ``op(_:_:)`` method have the same type, ``T``.
///
/// ### Creating an instance
///
/// For most use cases, call the factory function ``newMagma(_:)`` to create a
/// simple instance.
///
/// ```swift
/// let magma: any Magma<Int> = newMagma(+)
/// ```
///
/// You can also create your own type that conforms to the `Magma` protocol and
/// implement the ``op(_:_:)`` method.
///
/// ### Variants
///
/// If you need to emphasize the semantics of the magma's operation, use
/// ``AdditiveMagma`` or ``MultiplicativeMagma``.
public protocol Magma<T> {
    
    /// The type that this algebraic structure is defined for.
    associatedtype T
    
    /// The binary operation of this algebraic structure.
    ///
    /// - Parameters:
    ///   - t1: The first operand.
    ///   - t2: The second operand.
    ///
    /// - Returns: The value resulting from applying the operation to the
    ///   operands.
    func op(_ t1: T, _ t2: T) -> T
}


/// A magma whose operation has the semantics of addition.
public protocol AdditiveMagma<T> {

    /// The type that this algebraic structure is defined on.
    associatedtype T
    
    /// The addition operation of this algebraic structure.
    ///
    /// - Parameters:
    ///   - t1: The first addend.
    ///   - t2: The second addend.
    ///
    /// - Returns: The sum of the two addends.
    func add(_ t1: T, _ t2: T) -> T
}
extension AdditiveMagma {
    /// Adapts this additive magma to be a magma whose operation has no specific
    /// semantics.
    ///
    /// - Returns: A magma with the same behavior, only adapted to conform to
    ///   ``Magma`` protocol.
    public func asMagma() -> any Magma<T> {
        AnyMagma(add)
    }
}


/// A magma whose operation has the semantics of multiplication.
public protocol MultiplicativeMagma<T> {

    /// The type that this algebraic structure is defined on.
    associatedtype T
    
    /// The multiplication operation of this algebraic structure.
    ///
    /// - Parameters:
    ///   - t1: The first factor.
    ///   - t2: The second factor.
    ///
    /// - Returns: The product of the two factors.
    func mul(_ t1: T, _ t2: T) -> T
}
extension MultiplicativeMagma {
    /// Adapts this multiplicative magma to be a magma whose operation has no
    /// specific semantics.
    ///
    /// - Returns: A magma with the same behavior, only adapted to conform to
    ///   ``Magma`` protocol.
    public func asMagma() -> any Magma<T> {
        AnyMagma(mul)
    }
}

// MARK: Factory Functions

/// Creates a new magma from a binary operation.
///
/// Example:
///
/// ```swift
/// let magma: any Magma<Int> = newMagma(+)
/// ```
///
/// - Parameter op: The binary operation.
///
/// - Returns: A new magma with the specified binary operation.
public func newMagma<T>(_ op: @escaping (T, T) -> T) -> some Magma<T> {
    AnyMagma(op)
}

/// Creates a new additive magma from an addition operation.
///
/// Example:
///
/// ```swift
/// let magma: any AdditiveMagma<Int> = newAdditiveMagma(+)
/// ```
///
/// - Parameter add: The addition operation.
///
/// - Returns: A new magma with the specified addition operation.
public func newAdditiveMagma<T>(
    _ add: @escaping (T, T) -> T
) -> some AdditiveMagma<T> {
    AnyAdditiveMagma(add)
}

/// Creates a new multiplicative magma from a multiplication operation.
///
/// Example:
///
/// ```swift
/// let magma: any MultiplicativeMagma<Int> = newMultiplicativeMagma(+)
/// ```
///
/// - Parameter mul: The multiplication operation.
///
/// - Returns: A new magma with the specified multiplication operation.
public func newMultiplicativeMagma<T>(
    _ mul: @escaping (T, T) -> T
) -> some MultiplicativeMagma<T> {
    AnyMultiplicativeMagma(mul)
}

// MARK: Concrete Implementations

struct AnyMagma<T>: Magma {
    private let _op: (T, T) -> T
    init(_ op: @escaping (T, T) -> T) {
        self._op = op
    }
    func op(_ t1: T, _ t2: T) -> T {
        self._op(t1, t2)
    }
}

struct AnyAdditiveMagma<T>: AdditiveMagma {
    private let _add: (T, T) -> T
    init(_ add: @escaping (T, T) -> T) {
        self._add = add
    }
    func add(_ t1: T, _ t2: T) -> T {
        self._add(t1, t2)
    }
}

struct AnyMultiplicativeMagma<T>: MultiplicativeMagma {
    private let _mul: (T, T) -> T
    init(_ mul: @escaping (T, T) -> T) {
        self._mul = mul
    }
    func mul(_ t1: T, _ t2: T) -> T {
        self._mul(t1, t2)
    }
}
