// Product+Append.swift
// Append/prepend — extend the pack by one component on either end.
//
// Instance-canonical (see Product+Map.swift for rationale).

// MARK: - Instance layer (canonical implementations)

extension Product {
    /// Returns a new Product with `value` appended as the last component,
    /// consuming `self`.
    ///
    /// ```swift
    /// let pair = Product(1, "hi")
    /// let triple = pair.append(true)   // Product<Int, String, Bool>
    /// ```
    @inlinable
    public consuming func append<T>(
        _ value: consuming T
    ) -> Product<repeat each Element, T> {
        Product<repeat each Element, T>(repeat each values, value)
    }

    /// Returns a new Product with `value` prepended as the first component,
    /// consuming `self`.
    ///
    /// ```swift
    /// let pair = Product(1, "hi")
    /// let triple = pair.prepend(0.5)   // Product<Double, Int, String>
    /// ```
    @inlinable
    public consuming func prepend<T>(
        _ value: consuming T
    ) -> Product<T, repeat each Element> {
        Product<T, repeat each Element>(value, repeat each values)
    }
}

// MARK: - Static layer (delegates to instance)

extension Product {
    /// Static form of ``append(_:)``.
    @inlinable
    public static func append<T>(
        _ product: consuming Product,
        _ value: consuming T
    ) -> Product<repeat each Element, T> {
        product.append(value)
    }

    /// Static form of ``prepend(_:)``.
    @inlinable
    public static func prepend<T>(
        _ product: consuming Product,
        _ value: consuming T
    ) -> Product<T, repeat each Element> {
        product.prepend(value)
    }
}
