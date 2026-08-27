@dynamicMemberLookup
public struct Product<each Element> {

    public var values: (repeat each Element)

    @inlinable
    public init(_ values: repeat each Element) {
        self.values = (repeat each values)
    }
}

extension Product {

    @inlinable
    public subscript<T>(dynamicMember keyPath: KeyPath<(repeat each Element), T>) -> T {
        values[keyPath: keyPath]
    }
}

extension Product: Sendable where repeat each Element: Sendable {}
