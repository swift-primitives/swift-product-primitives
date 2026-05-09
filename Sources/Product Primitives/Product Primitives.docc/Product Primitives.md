# ``Product_Primitives``

@Metadata {
    @DisplayName("Product Primitives")
    @TitleHeading("Swift Institute — Primitives Layer")
}

The n-ary cartesian product type for typed multi-component values.

## Overview

`Product Primitives` ships ``Product_Primitives/Product``, a generic
struct representing the categorical n-ary product `A × B × C × ...`
implemented over Swift's parameter packs. `Product` is a named wrapper
around a Swift tuple with key-path-driven dynamic member lookup, so
`product.0` reads the first element directly rather than going through
`product.values.0`.

`Product` is conditionally `Sendable`, `Equatable`, `Hashable`,
`Comparable`, `CustomStringConvertible`, `Encodable`, and `Decodable`,
and conforms to `Swift.Error` when every component is itself an
`Error` — useful for typed multi-cause error aggregation. Under
Swift < 6.4 it additionally conforms to `Equation.Protocol`,
`Hash.Protocol`, and `Comparison.Protocol` per SE-0499 (under
Swift 6.4+ those are typealiases to the stdlib protocols).

## Lifecycle: movement, not management

`Product` is a *movement vehicle* — it transports its components as one
unit. It does NOT close, unlock, or otherwise act on its components on
drop. Lifecycle decisions belong to the consumer.

## ~Escapable arms

`Product`'s arms are currently `Copyable` and `Escapable` only. Parameter-
pack syntax does not yet admit `each T: ~Copyable` or `each T: ~Escapable`
in Swift 6.3.1 or 6.4-dev, so the cohort siblings ``Pair_Primitives/Pair``
and ``Either_Primitives/Either`` admit `~Escapable` arms while `Product`
does not. Revisit when Swift's parameter-pack support extends to
suppressed conformances; until then, consumers needing `~Escapable` arms
in arity-2 use `Pair`.

## Topics

### The Product

- ``Product_Primitives/Product``
