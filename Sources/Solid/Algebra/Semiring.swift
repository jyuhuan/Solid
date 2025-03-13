/// An algebraic structure with two operations, addition and multiplication,
/// each with its own identity element.
///
/// A semiring is an algebraic structure consisting of:
/// - a type: `T`,
/// - a commutative, associative addition operation: `add(T, T) -> T`,
/// - an identity element for the addition operation: `zero`,
/// - an associative multiplication operation: `mul(T, T) -> T`, and
/// - an identity element for the multiplication operation: `one`.
///
/// In short, a semiring combines a additive commutative monoid and a
/// multiplicative monoid.
///
/// ### Mathematical requirements
///
/// - **Closure property**. The result of both addition and multiplication must
///   also be a member of the semiring's type. This is automatically satisfied
///   by the fact that the operands (input) and the return value (output) of
///   ``AdditiveMagma/add(_:_:)`` and ``MultiplicativeMagma/mul(_:_:)`` all have
///   the same type, ``Magma/T``.
///
/// - **Associative addition**. Addition in a semiring must be associative. For
///   example, for integers, `+` is associative, while `-` is not:
///
///   ```
///   (1 + 2) + 3 == 1 + (2 + 3)
///   (1 - 2) - 3 != 1 - (2 - 3)
///   ```
///
/// - **Commutative addition**. Addition in a semiring must be commutative. For
///   example, for integers, `+` is commutative, while `-` is not:
///
///   ```
///   1 + 2 == 2 + 1
///   1 - 2 != 2 - 1
///   ```
///
/// - **Associative multiplication**. Multiplication operation in a semiring
///   must be associative. For example, for integers, `*` is associative, while
///   `/` is not:
///
///   ```
///   (1 * 2) * 3 == 1 * (2 * 3)
///   (1 / 2) / 3 != 1 / (2 / 3)
///   ```
///
/// - **Identity elements**. The identity elements, zero and one, must satisfy
///   the following requirement:
///
///   ```swift
///   let semiring: any Semiring<T> = // ...
///   let element: T = // ...
///   semiring.add(semiring.zero, element) == element
///   semiring.add(element, semiring.zero) == element
///   semiring.mul(semiring.one, element) == element
///   semiring.mul(element, semiring.one) == element
///   ```
///
/// - **Absorbing zero**. The additive identity element, zero, must satisfy the
///   following property for multiplication:
///
///   ```swift
///   let semiring: any Semiring<T> = // ...
///   let element: T = // ...
///   semiring.mul(semiring.zero, element) == semiring.zero
///   semiring.mul(element, semiring.zero) == semiring.zero
///   ```
///
/// - **Distributive multiplication**. Multiplication distributes over addition:
///
///   ```swift
///   let r: any Semiring<T> = // ...
///   let e1: T = // ...
///   let e2: T = // ...
///   let e3: T = // ...
///   r.mul(e1, r.add(e2, e3)) == r.add(r.mul(e1, e2), r.mul(e1, e3))
///   r.mul(r.add(e2, e3), e1) == r.add(r.mul(e2, e1), r.mul(e3, e1))
///   ```
///
/// ### Creating an instance
///
/// For most use cases, call the factory function
/// ``newSemiring(zero:one:add:mul:)`` or
/// ``newSemiring(additiveMonoid:multiplicativeMonoid:)`` to create a simple
/// instance.
///
/// ```swift
/// let semiring1: any Semiring<UInt> = newSemiring(
///     zero: 0,
///     one: 1,
///     add: +,
///     mul: *
/// )
/// let semiring2: any Semiring<UInt> = newSemiring(
///     additiveMonoid: newAdditiveMonoid(zero: 0, add: +),
///     multiplicativeMonoid: newMultiplicativeMonoid(one: 1, mul: *)
/// )
/// ```
///
/// You can also create your own type that conforms to the `Semiring` protocol,
/// and implement the `add` and `mul` methods, as well as the `zero` and `one`
/// properties.
public protocol Semiring<T>: AdditiveMonoid & Commutative, MultiplicativeMonoid { }


// MARK: Factory Function

/// Creates a new semiring from two operations and two identity elements.
///
/// Example:
///
/// ```swift
/// let semiring: any Semiring<Int> = newSemiring(
///     zero: 0,
///     one: 1,
///     add: +,
///     mul: *
/// )
/// ```
///
/// - Parameters:
///   - zero: The additive identity element.
///   - one: The multiplicative identity element
///   - add: The additive operation. Must be associative and commutative.
///   - mul: The multiplicative operation. Must be associative.
///
/// - Returns: A new semiring with the specified operations and identity
///   elements.
public func newSemiring<T>(
    zero: T,
    one: T,
    add: @escaping (T, T) -> T,
    mul: @escaping (T, T) -> T
) -> some Semiring<T> {
    AnySemiring(zero: zero, one: one, add: add, mul: mul)
}


/// Creates a new semiring from two monoids.
/// - Parameters:
///   - additiveMonoid: The commutative additive monoid.
///   - multiplicativeMonoid: The multiplicative monoid.
/// - Returns: A new semiring consisting of the two specified monoids.
public func newSemiring<T>(
    additiveMonoid: any Monoid<T>,
    multiplicativeMonoid: any Monoid<T>
) -> some Semiring<T> {
    AnySemiring<T>(
        zero: additiveMonoid.id,
        one: multiplicativeMonoid.id,
        add: additiveMonoid.op,
        mul: multiplicativeMonoid.op
    )
}


// MARK: Concrete Implementations

struct AnySemiring<T>: Semiring {
    let zero: T
    let one: T
    private let _add: (T, T) -> T
    private let _mul: (T, T) -> T
    
    init(
        zero: T,
        one: T,
        add: @escaping (T, T) -> T,
        mul: @escaping (T, T) -> T
    ) {
        self.zero = zero
        self.one = one
        self._add = add
        self._mul = mul
    }
    
    func add(_ t1: T, _ t2: T) -> T {
        self._add(t1, t2)
    }
    
    func mul(_ t1: T, _ t2: T) -> T {
        self._mul(t1, t2)
    }
}
