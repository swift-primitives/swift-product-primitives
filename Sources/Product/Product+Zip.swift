extension Product {

    @inlinable
    public consuming func zip<each Other>(
        _ other: consuming Product<repeat each Other>
    ) -> Product<repeat (each Element, each Other)> {
        Product<repeat (each Element, each Other)>(
            repeat (each values, each other.values)
        )
    }
}

extension Product {

    @inlinable
    public static func zip<each Other>(
        _ product: consuming Product,
        _ other: consuming Product<repeat each Other>
    ) -> Product<repeat (each Element, each Other)> {
        product.zip(other)
    }
}
