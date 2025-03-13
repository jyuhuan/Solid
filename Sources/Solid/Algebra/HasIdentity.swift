/// A type with an identity element for an operation in an algebraic structure.
///
/// An identity element in an algebraic structure must satisfy the following
/// requirement:
///
/// ```swift
/// let a = // an algebraic structure (e.g., a Monoid)
/// let x = // an element from the algebraic structure's set
/// a.op(a.id, x) == x
/// a.op(x, a.id) == x
/// ```
public protocol HasIdentity<T> {
    associatedtype T
    
    /// The identity element.
    var id: T { get }
}

/// A type with an identity element for an additive operation in an algebraic
/// structure.
///
/// For an additive operation, its identity element is often called the "zero".
/// The "zero" must satisfy the following requirement:
///
/// ```swift
/// let a = // an additive algebraic structure (e.g., an AdditiveMonoid)
/// let x = // an element from the additive algebraic structure's set
/// a.add(a.zero, x) == x
/// a.add(x, a.zero) == x
/// ```
public protocol HasAdditiveIdentity<T> {
    associatedtype T
    
    /// The additive identity element.
    var zero: T { get }
}

/// A type with an identity element for a multiplicative operation in an
/// algebraic structure.
///
/// For a multiplicative operation, its identity element is often called the
/// "one". The "one" must satisfy the following requirement:
///
/// ```swift
/// let a = // a multiplicative algebraic structure (e.g., a MultiplicativeMonoid)
/// let x = // an element from the multiplicative algebraic structure's set
/// a.mul(a.one, x) == x
/// a.mul(x, a.one) == x
/// ```
public protocol HasMultiplicativeIdentity<T> {
    associatedtype T
    
    /// The multiplicative identity element.
    var one: T { get }
}
