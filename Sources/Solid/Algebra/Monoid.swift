/// An algebraic structure with an associative binary operation and an identity
/// element.
///
/// A monoid is an algebraic structure consisting of:
/// - a type: `T`,
/// - an associative binary operation: `(T, T) -> T`, and
/// - an identity element for the binary operation: `id`.
///
/// In short, a monoid is a ``Semigroup`` with an identity element.
///
/// ### Mathematical requirements
///
/// - **Closure property**. The result of the binary operation must also be a
///   member of the monoid's type. This is automatically satisfied by the fact
///   that the operands (input) and the return value (output) of the
///   ``Magma/op(_:_:)`` method have the same type, ``Magma/T``.
///
/// - **Associative operation**. The binary operation in a monoid must be
///   associative. For example, for integers, `+` is associative, while `-` is
///   not:
///
///   ```
///   (1 + 2) + 3 == 1 + (2 + 3)
///   (1 - 2) - 3 != 1 - (2 - 3)
///   ```
///
/// - **Identity element**. The identity element must satisfy the following
///   requirement:
///
///   ```swift
///   let monoid: any Monoid<T> = ...
///   let element: T = ...
///   monoid.op(monoid.id, element) == element
///   monoid.op(element, monoid.id) == element
///   ```
///
/// ### Creating an instance
///
/// For most use cases, call the factory function ``newMonoid(id:op:)`` to
/// create a simple instance.
///
/// ```swift
/// let monoid: any Monoid<Int> = newMonoid(id: 0, op: +)
/// ```
///
/// You can also create your own type that conforms to the `Monoid` protocol,
/// and implement the `op` method and the `id` property.
///
/// ### Variants
///
/// If you need to emphasize on the semantics of a semigroup, consider using
/// ``AdditiveMonoid`` or ``MultiplicativeMonoid``.
public protocol Monoid<T>: Semigroup & HasIdentity { }


/// A monoid whose operation has the semantics of addition.
public protocol AdditiveMonoid<T>: AdditiveSemigroup & HasAdditiveIdentity { }
extension AdditiveMonoid {
    /// Adapts this additive monoid to be a monoid whose operation has no
    /// specific semantics.
    /// - Returns: A monoid with the same behavior, only adapted to conform to
    ///   the ordinary ``Monoid`` protocol.
    public func asMonoid() -> some Monoid<T> {
        AnyMonoid(id: self.zero, op: self.add)
    }
}


/// A monoid whose operation has the semantics of multiplication.
public protocol MultiplicativeMonoid<T>: MultiplicativeSemigroup & HasMultiplicativeIdentity { }
extension MultiplicativeMonoid {
    /// Adapts this multiplicative monoid to be a monoid whose operation has no
    /// specific semantics.
    ///
    /// - Returns: A monoid with the same behavior, only adapted to conform to
    ///   the ordinary ``Monoid`` protocol.
    public func asMonoid() -> some Monoid<T> {
        return AnyMonoid(id: self.one, op: self.mul)
    }
}


// MARK: Factory Functions

/// Creates a new monoid from a binary operation and an identity element.
///
/// Example:
///
/// ```swift
/// let monoid: any Monoid<Int> = newMonoid(id: 0, op: +)
/// ```
///
/// - Parameters:
///   - id: The identity element.
///   - op: The binary operation. Must be associative.
///
/// - Returns: A new semigroup with the specified binary operation and identity
///   element.
public func newMonoid<T>(
    id: T,
    op: @escaping (T, T) -> T
) -> some Monoid<T> {
    AnyMonoid(id: id, op: op)
}

/// Creates a new monoid from an addition operation and an additive identity
/// element.
///
/// Example:
///
/// ```swift
/// let monoid: any AdditiveMonoid<Int> = newAdditiveMonoid(id: 0, op: +)
/// ```
///
/// - Parameters:
///   - zero: The additive identity element.
///   - add: The addition operation. Must be associative.
///
/// - Returns: A new semigroup with the specified addition operation and
///   additive identity element.
public func newAdditiveMonoid<T>(
    zero: T,
    add: @escaping (T, T) -> T
) -> some AdditiveMonoid<T> {
    AnyAdditiveMonoid(zero: zero, add: add)
}

/// Creates a new monoid from a multiplication operation and an multiplicative
/// identity element.
///
/// Example:
///
/// ```swift
/// let monoid: any MultiplicativeMonoid<Int> = newMultiplicativeMonoid(id: 0, op: +)
/// ```
///
/// - Parameters:
///   - one: The multiplicative identity element.
///   - mul: The multiplication operation. Must be associative.
///   
/// - Returns: A new semigroup with the specified multiplication operation and
///   multiplicative identity element.
public func newMultiplicativeMonoid<T>(
    one: T,
    mul: @escaping (T, T) -> T
) -> some MultiplicativeMonoid<T> {
    AnyMultiplicativeMonoid(one: one, mul: mul)
}


// MARK: Concrete Implementations

struct AnyMonoid<T>: Monoid {
    let id: T
    let _op: (T, T) -> T
    
    init(id: T, op: @escaping (T, T) -> T) {
        self.id = id
        self._op = op
    }
    
    func op(_ t1: T, _ t2: T) -> T {
        self._op(t1, t2)
    }
}

struct AnyAdditiveMonoid<T>: AdditiveMonoid {
    let zero: T
    let _add: (T, T) -> T
    
    init(zero: T, add: @escaping (T, T) -> T) {
        self.zero = zero
        self._add = add
    }
    
    func add(_ t1: T, _ t2: T) -> T {
        self._add(t1, t2)
    }
}

struct AnyMultiplicativeMonoid<T>: MultiplicativeMonoid {
    private let _one: T
    private let _mul: (T, T) -> T
    
    init(one: T, mul: @escaping (T, T) -> T) {
        self._one = one
        self._mul = mul
    }
    
    var one: T {
        self._one
    }
    
    func mul(_ t1: T, _ t2: T) -> T {
        self._mul(t1, t2)
    }
}
