// Product+Fold.swift
// Catamorphism — eliminates the Product by folding all components.
//
// Instance-canonical (see Product+Map.swift for rationale).

// MARK: - Instance layer (canonical implementation)

extension Product {
    /// Eliminates the Product by handling all components in a single closure,
    /// consuming `self`.
    ///
    /// ```swift
    /// let triple = Product(1, "hi", true)
    /// let s = triple.fold { a, b, c in "\(a) \(b) \(c)" }
    /// // "1 hi true"
    /// ```
    @inlinable
    public consuming func fold<R, E: Swift.Error>(
        _ body: (repeat each Element) throws(E) -> R
    ) throws(E) -> R {
        try body(repeat each values)
    }
}

// MARK: - Static layer (delegates to instance)

extension Product {
    /// Static form of ``fold(_:)``.
    @inlinable
    public static func fold<R, E: Swift.Error>(
        _ product: consuming Product,
        _ body: (repeat each Element) throws(E) -> R
    ) throws(E) -> R {
        try product.fold(body)
    }
}
