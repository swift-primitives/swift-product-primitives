// Product+Zip.swift
// Pointwise pairing of two Products into a Product of tuples.
//
// Instance-canonical (see Product+Map.swift for rationale).

// MARK: - Instance layer (canonical implementation)

extension Product {
    /// Returns a Product whose i-th component is the tuple `(self.i, other.i)`,
    /// consuming both `self` and `other`.
    ///
    /// Both Products must have the same arity.
    ///
    /// ```swift
    /// let a = Product(1, "hi")
    /// let b = Product(true, 0.5)
    /// let z = a.zip(b)   // Product<(Int, Bool), (String, Double)>
    /// ```
    @inlinable
    public consuming func zip<each Other>(
        _ other: consuming Product<repeat each Other>
    ) -> Product<repeat (each Element, each Other)> {
        Product<repeat (each Element, each Other)>(
            repeat (each values, each other.values)
        )
    }
}

// MARK: - Static layer (delegates to instance)

extension Product {
    /// Static form of ``zip(_:)``.
    @inlinable
    public static func zip<each Other>(
        _ product: consuming Product,
        _ other: consuming Product<repeat each Other>
    ) -> Product<repeat (each Element, each Other)> {
        product.zip(other)
    }
}
