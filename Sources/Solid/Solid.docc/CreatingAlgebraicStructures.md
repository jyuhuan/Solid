# Creating Algebraic Structures

Factory functions for creating instances of algebraic structures.

## Overview

To create an algebraic structure, use one of the factory functions.

Examples:

```swift
let magma: any Magma<Int> = newMagma(+)
let semigroup: any Semigroup<Int> = newSemigroup(+)
let monoid: any Monoid<Int> = newMonoid(id: 0, op: +)
let semiring: any Semiring<Int> = newSemiring(zero: 0, one: 1, add: +, mul: *)
```

## Topics

### Creating a magma
- ``newMagma(_:)``
- ``newAdditiveMagma(_:)``
- ``newMultiplicativeMagma(_:)``

### Creating a semigroup
- ``newSemigroup(_:)``
- ``newAdditiveSemigroup(_:)``
- ``newMultiplicativeSemigroup(_:)``

### Creating a monoid
- ``newMonoid(id:op:)``
- ``newAdditiveMonoid(zero:add:)``
- ``newMultiplicativeMonoid(one:mul:)``

### Creating a semiring
- ``newSemiring(zero:one:add:mul:)``
- ``newSemiring(additiveMonoid:multiplicativeMonoid:)``
