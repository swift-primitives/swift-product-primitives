extension Product {

    @inlinable
    public consuming func append<T>(
        _ value: consuming T
    ) -> Product<repeat each Element, T> {
        Product<repeat each Element, T>(repeat each values, value)
    }

    @inlinable
    public consuming func prepend<T>(
        _ value: consuming T
    ) -> Product<T, repeat each Element> {
        Product<T, repeat each Element>(value, repeat each values)
    }
}

extension Product {

    @inlinable
    public static func append<T>(
        _ product: consuming Product,
        _ value: consuming T
    ) -> Product<repeat each Element, T> {
        product.append(value)
    }

    @inlinable
    public static func prepend<T>(
        _ product: consuming Product,
        _ value: consuming T
    ) -> Product<T, repeat each Element> {
        product.prepend(value)
    }
}
