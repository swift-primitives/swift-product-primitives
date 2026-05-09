// Product+Map.swift
// Per-component transform (functor surface).
//
// Instance-canonical for Product (different from Pair / Either, which are
// static-canonical). Reason: pack-expand of a member-access on a `consuming`
// parameter (`each product.values`) crashes the Swift 6.3.1 / 6.4-dev
// nightly compiler (SIGSEGV in swift-frontend). A workaround that extracts
// `.values` to a local let via `(consume product).values` compiles but adds
// indirection. Pack expansion on `self` (`each values`) inside a `consuming`
// instance method works directly. Methods are `consuming` for forward-
// compatibility with eventual `~Copyable each T` support; the static layer
// delegates to the instance method.

// MARK: - Instance layer (canonical implementation)

extension Product {
    /// Transforms every component, consuming `self`.
    ///
    /// ```swift
    /// let triple = Product(1, "hi", true)
    /// let transformed = try triple.map(
    ///     { $0 + 1 },
    ///     { $0.uppercased() },
    ///     { !$0 }
    /// )
    /// // Product<Int, String, Bool> = (2, "HI", false)
    /// ```
    @inlinable
    public consuming func map<each NewElement, E: Swift.Error>(
        _ transforms: repeat (each Element) throws(E) -> each NewElement
    ) throws(E) -> Product<repeat each NewElement> {
        Product<repeat each NewElement>(
            repeat try (each transforms)(each values)
        )
    }
}

// MARK: - Static layer (delegates to instance)

extension Product {
    /// Static form of ``map(_:)``.
    @inlinable
    public static func map<each NewElement, E: Swift.Error>(
        _ product: consuming Product,
        _ transforms: repeat (each Element) throws(E) -> each NewElement
    ) throws(E) -> Product<repeat each NewElement> {
        try product.map(repeat each transforms)
    }
}
