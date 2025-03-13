# Algebraic Structures

Protocols for abstract algebraic structures.

## Overview

Writing code that relies on an algebraic structure instead of hardcoding algebraic logic enables code reuse and improves flexibility. 

Many APIs in Solid are designed to accept an algebraic structure. This enable the framework to use the same implementation for a set of related algorithms that only differ by the underlying algebraic structure.


## Topics

### Magmas
- ``Solid/Magma``
- ``Solid/AdditiveMagma``
- ``Solid/MultiplicativeMagma``

### Semigroups
- ``Solid/Semigroup``
- ``Solid/AdditiveSemigroup``
- ``Solid/MultiplicativeSemigroup``

### Monoids
- ``Solid/Monoid``
- ``Solid/AdditiveMonoid``
- ``Solid/MultiplicativeMonoid``

### Semiring
- ``Solid/Semiring``

### Identity elements
- ``Solid/HasIdentity``
- ``Solid/HasAdditiveIdentity``
- ``Solid/HasMultiplicativeIdentity``

### Operation property markers
- ``Solid/Commutative``
